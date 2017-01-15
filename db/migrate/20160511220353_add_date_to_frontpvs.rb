class AddDateToFrontpvs < ActiveRecord::Migration
  def change
    add_column :frontpvs, :date, :string
  end
end
