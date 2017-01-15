class AddDdateyToDay < ActiveRecord::Migration
  def change
    add_column :days, :ddatey, :string
  end
end
