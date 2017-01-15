class AddDayRefToLecture < ActiveRecord::Migration
  def change
    add_reference :lectures, :day, index: true, foreign_key: true
  end
end
