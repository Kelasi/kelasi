class CreateTimelinePosts < ActiveRecord::Migration
  def change
    create_table :timeline_posts do |t|
      t.integer :timeline_id
      t.integer :user_id
      t.integer :parent_id
      t.integer :state, default: 1
      t.string :body

      t.timestamps
    end
    add_index :timeline_posts, :timeline_id
    add_index :timeline_posts, :parent_id
    add_index :timeline_posts, :state
  end
end
