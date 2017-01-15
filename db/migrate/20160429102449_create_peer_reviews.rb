class CreatePeerReviews < ActiveRecord::Migration
  def change
    create_table :peer_reviews do |t|
      t.integer :user_id
      t.integer :manager_id
      t.text :e_objective_response
      t.text :e_overall_comments
      t.text :e_personal_development
      t.text :m_objective_response
      t.text :m_overall_comments
      t.text :m_personal_development
      t.datetime :deadline

      t.timestamps null: false
    end
  end
end
