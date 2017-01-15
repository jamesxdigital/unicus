class RemoveColumnFromDay < ActiveRecord::Migration
  def self.up
  remove_column :days, :column
end
end
