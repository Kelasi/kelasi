class AddIntroducerToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :user
    end
  end
end
