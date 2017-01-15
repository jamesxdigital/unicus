class RemoveSpeakerIdFromLectures < ActiveRecord::Migration
  def change
    remove_column :lectures, :speaker_id, :integer
  end
end
