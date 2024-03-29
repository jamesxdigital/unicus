class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|

      t.integer 'user_id'
      t.string 'title'
      t.string 'category'
      t.text 'comments'
      t.boolean 'approved'

      t.timestamps null: false
    end
  end
end
