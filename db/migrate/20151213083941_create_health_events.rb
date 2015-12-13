class CreateHealthEvents < ActiveRecord::Migration
  def change
    create_table :health_events do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :comment
      t.string :feeling
      t.datetime :occurred_at, null: false
      t.datetime :ended_at
      t.integer :public_level, null: false, default: 0

      t.timestamps null: false
      t.index [:user_id, :occurred_at]
    end
  end
end
