class CreateMailerSettings < ActiveRecord::Migration
  def change
    create_table :mailer_settings do |t|

    	t.integer :user_id
    	t.boolean :when_objective_added, default: true
    	t.boolean :when_objective_proposed, default: true
    	t.boolean :when_objective_approved, default: true
    	t.boolean :when_objective_rejected, default: true
    	t.boolean :when_peer_review_added,default: true
    	t.boolean :when_peer_review_updated, default: true
    	t.boolean :when_user_added, default: true
    	t.boolean :when_account_activated, default: true
    end
    add_index :mailer_settings,:user_id
  end
end
