class ChangeColumnInSpeaker < ActiveRecord::Migration
  def change
    change_column :speakers, :speaker_title, :string, :null => true
    change_column :speakers, :forename, :string, :null => true
    change_column :speakers, :surname, :string, :null => true
    change_column :speakers, :organisation, :string, :null => true
    change_column :speakers, :email, :string, :null => true
    change_column :speakers, :website, :string, :null => true
    change_column :speakers, :facebook, :string, :null => true
    change_column :speakers, :twitter, :string, :null => true
  end
end
