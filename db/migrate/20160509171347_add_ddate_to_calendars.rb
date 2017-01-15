class AddDdateToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :ddate, :string
  end
end
