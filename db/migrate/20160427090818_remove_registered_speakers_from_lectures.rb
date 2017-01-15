class RemoveRegisteredSpeakersFromLectures < ActiveRecord::Migration
  def change
    remove_column :lectures, :registered_speakers, :string
  end
end
