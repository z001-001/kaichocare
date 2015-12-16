class Bowel < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :shape, presence: true
  validates :comment, length: { maximum: 140 }
  validates :occurred_at, presence: true
  validates :public_level, presence: true
  
  # Bristol Stool Scale / Chart
  # ブリストルスケール
  enum shape: {
    unknown: 0,         # 不明
    hard_lumps: 1,      # コロコロ便
    lumpy: 2,           # 硬い便
    cracky_sausage: 3,  # やや硬い便
    normal: 4,          # 普通便
    soft_blobs: 5,      # やや軟らかい便
    mushy: 6,           # 泥状便
    liquid: 7,          # 水様便
  }
end
