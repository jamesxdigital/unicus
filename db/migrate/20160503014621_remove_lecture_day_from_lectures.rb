class RemoveLectureDayFromLectures < ActiveRecord::Migration
  def change
    remove_column :lectures, :lecture_day, :string
  end
end
