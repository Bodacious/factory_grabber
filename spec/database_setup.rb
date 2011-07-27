require 'active_record'
ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => "dbfile"

ActiveRecord::Base.connection.create_table :users, :force => true do |t| 
  t.string :first_name
  t.string :last_name
  t.string :email
  t.boolean :admin
end