class ArticlesController < ApplicationController

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
		@articulo = Article.find(params[:id])
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
		#para crear el artículo se crea una variable @articulo con el 
		#metodo new de la siguiente forma:
		@articulo = Article.new(title: params[:article][:title], 
								body: params[:article][:body])
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

end
