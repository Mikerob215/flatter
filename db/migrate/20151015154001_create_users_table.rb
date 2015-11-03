class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
    t.string :user_name
    t.string :password
    t.string :email
    t.string :location
    t.string :about
   end
end
end
