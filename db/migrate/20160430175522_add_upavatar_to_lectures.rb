class AddUpavatarToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :upavatar, :string
  end
end
