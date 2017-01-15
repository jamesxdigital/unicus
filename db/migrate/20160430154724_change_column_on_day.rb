class ChangeColumnOnDay < ActiveRecord::Migration
  def change
    change_column :days, :display_size, :integer, :null => true
  end
end
