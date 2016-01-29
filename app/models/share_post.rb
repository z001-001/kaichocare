class SharePost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true,  length: { maximum: 140 }
  validates :comment, presence: true, length: { maximum: 65535 }
  validates :public_level, presence: true
end
