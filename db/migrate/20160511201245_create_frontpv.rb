class CreateFrontpv < ActiveRecord::Migration
  def change
    create_table :frontpvs do |t|
      t.string :title
      t.string :message
    end
  end
end
