class AddLinkedinColumnToSpeaker < ActiveRecord::Migration
  def change
    add_column :speakers, :linkedIn, :string
  end
end
