class SorceryCore < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :encrypted_password, :crypted_password
      t.string :salt,             :default => nil
    end
  end
end

