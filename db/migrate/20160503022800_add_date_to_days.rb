class AddDateToDays < ActiveRecord::Migration
  def change
    add_column :days, :date, :string
  end
end
