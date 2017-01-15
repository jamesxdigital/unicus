class AddLtimeToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :ltime, :string
  end
end
