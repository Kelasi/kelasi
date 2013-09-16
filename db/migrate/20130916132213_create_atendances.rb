class CreateAtendances < ActiveRecord::Migration
  def change
    create_table :atendances do |t|
      t.reference :user
      t.reference :university

      t.timestamps
    end
  end
end
