class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
      t.integer 'user_id'
      t.string 'title'
      t.text 'description'
      t.boolean 'completed', default: false
      t.datetime 'deadline'
      t.timestamps null: false
    end
  end
end
