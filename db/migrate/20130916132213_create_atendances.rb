class CreateAtendances < ActiveRecord::Migration
  def change
    create_table :atendances do |t|
      t.references :user
      t.references :university

      t.timestamps
    end
  end
end
