class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.integer :user_id
      t.string :content_type
      t.references :attachable, polymorphic: true

      t.timestamps
    end

    add_index :media, :user_id
    add_index :media, :content_type
  end
end
