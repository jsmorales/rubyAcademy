#ver el video 4 de codigofacilito crear modelos con generador
class Article < ActiveRecord::Base

	#para hacer que un articulo pertenezca a un usuario hay que
	#crear una llave foranea user_id en la tabla de articulos
	#y luego migrar, la explicacion esta en la migracion add_user_id_to_articles
	#luego en el modelo se escribe lo siguiente para que sepa que pertenece
	#a esa entidad.
	belongs_to :user
	#y en el modelo del usuario se escribe has_many :articles lo cual
	#crea una relacion de uno a muchos.
	
	#la validacion de los campos que van a la bd le corresponde al modelo
	#en este caso para validar que un campo no esté vacío como title
	#se hace de la siguiente manera:

	#para validar que no exista un valor igual en ningun registro se utiliza
	#uniqueness: true
	validates :title, presence: true, uniqueness: true

	#aparte de validar que el cuerpo no sea vacio se especifica que deba tener
	#cierta cantidad de caracteres con length: { minimum: valor }
	validates :body, presence: true, length: { minimum: 20 }

	#en caso de querer validar con expresiones regulares se hace de la siguiente forma
	#validates :campod_bd , format: { with: /expresion_regular/ }

	#para setear el valor de las visitas visits_count se puede ejecutar un callback
	#llamado before_create:

	before_create :num_visitas

	def update_visitas
		#este metodo se llama desde el controlador para que actualize el campo visits_count
		#si el campo visits count es nulo lo actualiza a 1
		if self.visits_count.nil?
			self.update(visits_count: 1)
		else
			self.update(visits_count: self.visits_count + 1)
		end
		
	end

	private 

	def num_visitas
		self.visits_count = 0
	end

end
