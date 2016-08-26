class ArticlesController < ApplicationController

	#se declara que antes de cada accion menos show e index
	#se debe ejecutar validar_usuarios
	#before_action :validar_usuarios, except: [:show,:index]
	#para optimizar mejor se utiliza un helper llamado authenticate_user!
	before_action :authenticate_user!, except: [:show,:index]
	#este helper ya esta listo para saber si esta autenticado o no
	#y permitir o no el acceso al modulo al cual se quiere acceder.

	#otro callback seria set_articulo
	before_action :set_articulo, except: [:new,:create,:index]
	#---------------------------------------------------------------------

	#este ejecuta @articulo = Article.find(params[:id]) para no estar
	#repitiendo constantemente este trozo de código

	#se define la primera acción para articles index
	#GET articles/
	def index
		#la vista que va a llamar esta funcion esta dentro de views/articles/index.html.erb
		#en esta vista se van a listar todos los articulos creados, para hacer eso se utiliza
		#activerecord de la siguiente manera.

		#ya se tiene un modelo llamado models/article.rb
		#esto ya tiene metodos definidos como all y se usa de la siguiente manera
		@articulos = Article.all
		#ya teniedo los registros se utilizan variables de clase que son variables que se pueden acceder
		#desde todas partes y finalmente para pintarlos en la vista.
		#estas variables empiezan con el simbolo @

	end

	#se define la accion show para articles
	#GET articles/id
	def show
		#la vista para llamar a esta funcion esta dentro de views/articles/show.html.erb
		#para esta vista se va a mostrar un articulo en especial por su id
		#para mostrar cada uno de estos se crea una variable global utilizando un metodo
		#del active record llamado find, para saber cual es el id se utiliza params[:id]
		#esto carga los valores dentro de mi variable @articulo
		
		#@articulo = Article.find(params[:id]) optimizado por set_articulo en el callback
			
		#para buscar de otra forma se puede utilizar where de la siguiente forma:
		#Article.where("id = ?",params[:id])
		#también se puede utilizar un not 
		#Article.where.not("id = ?",params[:id])
		#el simbolo de interrogacion simboliza lo que se pasa por el valor despues de la coma
		#Article.where("id = ? OR title= ?",params[:id],params[:title])

		#se define que se debe ejecutar un metodo del modelo luego de pasar por aca
		#para que actualize las visitas del articulo
		@articulo.update_visitas
		#se inicializa un nuevo comentario ya que se muestra
		#el form de nuevo comentario para que pueda ser creado allí.
		@comment = Comment.new 
	end

	#se define la accion new para articles
	#GET articles/new
	def new
		#la vista para esta funcion es views/articles/new.html.erb
		#para poder crear un nuevo articulo se debe instanciar una variable
		#@articulo pero con el modelo de la siguiente manera.
		@articulo = Article.new
		#esto no va a permitir crear un formulario en la vista de este metodo
		#para la creacion del nuevo articulo.
	end

	#se define la accion create para articles
	#POST articles/
	def create 
		#esta accion se ejecuta cuado se accede a /articles con POST
		#---------------------------------------------------------------------
		#para crear el artículo se crea una variable @articulo con el 
		#metodo new de la siguiente forma:
		#@articulo = Article.new(title: params[:article][:title],body: params[:article][:body])
		#se cambia a esta forma de ingresar los datos ya que es mas seguro
		#gracias a los strong params definidos en la parte privada
		#Forma insegura @articulo = Article.new(params[:article]) 
		#Forma segura con Strong Params
		
		#@articulo = Article.new(articulo_params) este nos sirve si no hay que relacionarlo con usuario
		#para relacionar con un usuario se cambia el metodo de guardado de la siguiente manera
		@articulo = current_user.articles.new(articulo_params)
		#current_user es el objeto de usuario este ahora tiene un metodo articles
		#porque en el modelo se configuro la relacion de 1 a muchos.
		#has_many :articles

		#--------------------------------------------------------------------- 
		#para saber cuales son los parametros se debe ver el name en cada elemento.
		#con esto se toman los parametros pasados por el formulario
		#y se asignan a donde van a ser guardados.

		#para guardar esto se debe ejecutar lo siguiente
		#mas la validacion del guardado del mismo

		#tambien se pudiese validar @articulo.valid? devuelve true o false dependiendo de
		#si pasa todas las validaciones.

		if @articulo.save
			#esto redirige a la pagina de este articulo
			redirect_to @articulo
		else
			#si no se guardó, renderiza la accion new
			#en este caso seria  el formulario de nuevo articulo
			render :new
		end
		
	end

	#se define la funcion destroy para eliminar un articulo
	#DELETE /articles/:id
	def destroy
		#la vista es ...
		#sebusca cual es el articulo a eliminar dentro de una variable
		#@articulo = Article.find(params[:id]) --optimizado por callback
		#luego de tener el articulo se ejecuta el metodo destroy
		@articulo.destroy
		#en este caso se redirige a la vista de articulos
		redirect_to articles_path
	end

	#---------------------------------------------------------------------------------------------------

	#funcion que carga la vista para editar el articulo
	#get articles/:id/edit
	def edit
		#esto carga la vista
		#@articulo = Article.find(params[:id])  --optimizado por callback
	end

	#se define la funcion update para actualizar
	#ActiveRecord
	#PUT articles/:id
	def update
		#para actualizar se hace de la siguiente forma
		#@articulo.update_attributes({title: 'Nuevo titulo'})
		#se carga el articulo
		#@articulo = Article.find(params[:id])  --optimizado por callback
		#se actualiza con el metodo update y se le pasan los strong params
		#y se valida en el momento 
		if @articulo.update(articulo_params)
			#si se guardo lo redirige al articulo
			redirect_to @articulo
		else
			#si no lo guarda renderiza de nuevo la vista de
			#edicion para que se puedan ver los errores y 
			#hacerlo nuevamente.
			render :edit
		end


	end
	#---------------------------------------------------------------------------------------------------


	#metodos privados de la clase

	private

	#se define un metodo que da permiso de ingresar ciertos campos
	#a la base de datos por el metodo de
	#@articulo = Article.new(params[:article]) 
	def articulo_params
		#esto es conocido como strong params
		#esto no permite que se ingresen mas campos a la BD aparte de estos
		#definidos en esta funcion
		params.require(:article).permit(:title,:body)
	end

	#se define una funcion llamada set_articulo que setea un array con los
	#datos del articulo segun el id
	def set_articulo
		#esta funcion hace refactor de el trozo de codigo:
		@articulo = Article.find(params[:id])
		#lo cual me permite no repetirlo cada vez que inicia
		#una funcion que necesita inicializar el array con los
		#datos del artículo.
	end

	#se define un metodo para validar si el usuario ha iniciado sesion
	#y poder ejecutar las acciones de este controlador

=begin
	def validar_usuarios
		
		if user_signed_in?
			redirect_to new_user_session_path, notice: "Se necesita iniciar sesión."
		end

	end
=end

end
