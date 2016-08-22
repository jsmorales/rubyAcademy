=begin
	para lograr esta migracion se escrio en consola lo siguiente

	rails generate migration add_user_id_to_articles user:references

	y luego se corre rake db:migrate para que tome los cambios

=end
rescue Exception => e
	
end
class AddUserIdToArticles < ActiveRecord::Migration
  def change
    add_reference :articles, :user, index: true, foreign_key: true
  end
end
