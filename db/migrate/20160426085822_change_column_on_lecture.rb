class ChangeColumnOnLecture < ActiveRecord::Migration
  def change
    change_column :lectures, :lecture_title, :string, :null => false
    change_column :lectures, :lecture_day, :string, :null => false
    change_column :lectures, :column, :integer, :null => false
    change_column :lectures, :start_time, :string, :null => false
    change_column :lectures, :end_time, :string, :null => false
    change_column :lectures, :location, :string, :null => false
    change_column :lectures, :registered_speakers, :string, :null => false
    change_column :lectures, :description, :string, :null => false
  end
end
