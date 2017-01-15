class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :speaker_title
      t.string :forename
      t.string :surname
      t.string :organisation
      t.string :biography
      t.string :academic_background
      t.string :email
      t.string :website
      t.string :facebook
      t.string :twitter

      t.timestamps null: false
    end
  end
end
