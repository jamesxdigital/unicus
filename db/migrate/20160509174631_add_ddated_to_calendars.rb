class AddDdatedToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :ddated, :string
  end
end
