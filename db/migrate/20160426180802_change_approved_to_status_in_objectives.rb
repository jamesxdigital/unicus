class ChangeApprovedToStatusInObjectives < ActiveRecord::Migration

  def up
  	remove_column(:objectives,:approved)
  	add_column(:objectives,:status,:integer,{default: 0})
  end

  def down
  	add_column(:objectives,:approved,:boolean)
  	remove_column(:objectives,:status)
  end
end
