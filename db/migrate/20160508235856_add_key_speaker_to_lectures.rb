class AddKeySpeakerToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :key_speaker, :string
  end
end
