class AddPublicLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bowel_public_level, :integer, null: false, default: 1
    add_column :users, :health_event_public_level, :integer, null: false, default: 1
    add_column :users, :share_post_public_level, :integer, null: false, default: 1
  end
end
