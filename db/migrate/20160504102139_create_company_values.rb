class CreateCompanyValues < ActiveRecord::Migration
  def change
    create_table :company_values do |t|
      t.string :company_value
      t.string :icon
      t.string :colour

      t.timestamps null: false
    end
  end
end
