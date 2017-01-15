class AddSpeakerRefToLecture < ActiveRecord::Migration
  def change
    add_reference :lectures, :speaker, index: true, foreign_key: true
  end
end
