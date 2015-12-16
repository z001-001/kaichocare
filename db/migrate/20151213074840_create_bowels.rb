class CreateBowels < ActiveRecord::Migration
  def change
    create_table :bowels do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :shape, null: false, default: 0
      t.string :color
      t.integer :amount
      t.string :comment
      t.string :feeling
      t.datetime :occurred_at, null: false
      t.integer :public_level, null: false, default: 0

      t.timestamps null: false
      t.index [:user_id, :occurred_at]
    end
  end
end
