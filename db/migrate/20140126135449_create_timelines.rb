class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.string :title, :null => false

      t.timestamps
    end
  end
end
