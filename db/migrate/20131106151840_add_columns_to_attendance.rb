class AddColumnsToAttendance < ActiveRecord::Migration

  def change
    add_column :atendances, :from, :date, :default => ""
    add_column :atendances, :to, :date, :default => ""
    add_column :atendances, :currently_attending, :boolean, :null => false, :default => false
  end
end
