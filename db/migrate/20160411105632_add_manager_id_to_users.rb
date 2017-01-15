class AddManagerIdToUsers < ActiveRecord::Migration
  def up
  	add_column('users','manager_id',:integer,default: :nil)
  	add_index('users','manager_id')
  end

  def down
  	remove_index('users','manager_id')
  	remove_column('users','manager_id')
  end
end
