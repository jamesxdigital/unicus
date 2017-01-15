class AddPhotoToReview < ActiveRecord::Migration
  def change
    add_column :peer_reviews, :photo, :string
  end
end
