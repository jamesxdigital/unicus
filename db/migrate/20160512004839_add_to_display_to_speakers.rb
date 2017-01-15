class AddToDisplayToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :to_display, :string
  end
end
