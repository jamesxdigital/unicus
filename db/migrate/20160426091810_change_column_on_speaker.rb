class ChangeColumnOnSpeaker < ActiveRecord::Migration
  def change
    change_column :speakers, :speaker_title, :string, :null => false
    change_column :speakers, :forename, :string, :null => false
    change_column :speakers, :surname, :string, :null => false
    change_column :speakers, :organisation, :string, :null => false
    change_column :speakers, :email, :string, :null => false
    change_column :speakers, :website, :string, :null => false
    change_column :speakers, :facebook, :string, :null => false
    change_column :speakers, :twitter, :string, :null => false
  end
end
