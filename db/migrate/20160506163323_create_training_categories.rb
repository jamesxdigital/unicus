class CreateTrainingCategories < ActiveRecord::Migration
  def change
    create_table :training_categories do |t|
      t.text :category

      t.timestamps null: false
    end
  end
end
