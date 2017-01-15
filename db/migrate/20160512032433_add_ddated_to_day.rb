class AddDdatedToDay < ActiveRecord::Migration
  def change
    add_column :days, :ddated, :string
  end
end
