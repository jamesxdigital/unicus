class AddLocationToFrontpvs < ActiveRecord::Migration
  def change
    add_column :frontpvs, :location, :string
  end
end
