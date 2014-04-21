class AddFileAttributesToMedia < ActiveRecord::Migration
  def change
    add_column :media, :file_name, :string
    add_column :media, :file_size, :integer
  end
end
