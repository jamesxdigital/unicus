class AddLocationToLecture < ActiveRecord::Migration
  def change
    add_column :lectures, :location, :string
  end
end
