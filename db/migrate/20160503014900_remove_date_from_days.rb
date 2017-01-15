class RemoveDateFromDays < ActiveRecord::Migration
  def change
    remove_column :days, :date, :string
  end
end
