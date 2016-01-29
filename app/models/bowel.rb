class Bowel < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :shape, presence: true
  validates :color, presence: true
  validates :amount, presence: true
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
    soft_blobs: 5,      # やや軟便
    mushy: 6,           # 泥状便
    liquid: 7,          # 水様便
  }

  def self.shape_name(shape)
    case shape
    when "unknown", 0        then "不明"
    when "hard_lumps", 1     then "コロコロ便"
    when "lumpy", 2          then "硬い便"
    when "cracky_sausage", 3 then "やや硬い便"
    when "normal", 4         then "普通便"
    when "soft_blobs", 5     then "やや軟便"
    when "mushy", 6          then "泥状便"
    when "liquid", 7         then "水様便"
    else                          ""
    end
  end
end
