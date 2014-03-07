class CreateTimelineUserPermissions < ActiveRecord::Migration
  def change
    create_table :timeline_user_permissions do |t|
      t.integer :timeline_id
      t.integer :user_id
      t.integer :role

      t.timestamps
    end

    add_index :timeline_user_permissions, :timeline_id
    add_index :timeline_user_permissions, :user_id
    add_index :timeline_user_permissions, :role
  end
end
