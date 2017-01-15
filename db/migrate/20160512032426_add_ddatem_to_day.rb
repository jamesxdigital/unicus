class AddDdatemToDay < ActiveRecord::Migration
  def change
    add_column :days, :ddatem, :string
  end
end
