class AddDisplayEmailToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :display_email, :string
  end
end
