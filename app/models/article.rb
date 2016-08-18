#ver el video 4 de codigofacilito crear modelos con generador
class Article < ActiveRecord::Base
	
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

end
