class RemoveGuestSpeakersFromLectures < ActiveRecord::Migration
  def change
    remove_column :lectures, :guest_speakers, :string
  end
end
