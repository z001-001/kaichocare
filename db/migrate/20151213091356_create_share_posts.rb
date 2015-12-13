class CreateSharePosts < ActiveRecord::Migration
  def change
    create_table :share_posts do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :comment
      t.integer :public_level, null: false, default: 0

      t.timestamps null: false
      t.index [:user_id, :created_at]
    end
  end
end
