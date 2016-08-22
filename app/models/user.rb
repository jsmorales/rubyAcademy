class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #esto vienen de la relacion de uno a muchos entre usuario y articulos
  #ya explicado en el modelo de articulos y la migracion de la creacion
  #de la llave foranea.
  #Para terminar la relacion se escribe lo siguiente para configurar que
  #un usuario tiene varios articulos:
  has_many :articles

  #para hacer una comprobacion se escribe en la consola rails
  #Article.last.user, debe dar el resultado segun el usuario y
  #sus articulos.

end
