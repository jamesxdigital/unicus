class AddDdatemToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :ddatem, :string
  end
end
