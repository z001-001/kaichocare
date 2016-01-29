class AddFriendToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :friend, :boolean
  end
end
