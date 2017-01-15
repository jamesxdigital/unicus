class CreateMessagesTable < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.integer :user_id
    	t.integer :content_id, default: nil
    	t.integer :sender_id
    	t.boolean :seen
    	t.string :message_type
    	t.string :title
    	t.text :message
    	t.timestamps null: false
    end
    add_index :messages,:user_id
    add_index :messages,:content_id
    add_index :messages,:sender_id
  end
end
