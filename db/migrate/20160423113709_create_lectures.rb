class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :lecture_title
      t.string :lecture_day
      t.integer :column
      t.string :start_time
      t.string :end_time
      t.string :registered_speakers
      t.string :guest_speakers
      t.string :description

      t.timestamps null: false
    end
  end
end
