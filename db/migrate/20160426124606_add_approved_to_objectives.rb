class AddApprovedToObjectives < ActiveRecord::Migration
  def change
  	add_column(:objectives,:approved,:boolean) 
  end
end
