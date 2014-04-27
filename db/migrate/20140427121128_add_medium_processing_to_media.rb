class AddMediumProcessingToMedia < ActiveRecord::Migration
  def change
    add_column :media, :medium_processing, :boolean
  end
end
