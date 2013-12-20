class AddProfileNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_name, :string
    add_index :users, :profile_name, :unique => true
  end
end
