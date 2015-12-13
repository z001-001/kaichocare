class HealthEvent < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :title, length: { maximum: 140 }
  validates :comment, presence: true, length: { maximum: 65535 }
  validates :occurred_at, presence: true
  validates :public_level, presence: true
end
