class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         #:confirmable, :lockable, #:timeoutable,
         #:omniauthable, omniauth_providers: [:twitter]

  validates :username, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }
  validates :location, length: { maximum: 255 }
  validates :url, length: { maximum: 255 }

  has_many :bowels
  has_many :health_events
  has_many :share_posts

  # フォロー関連
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed

  # フォロワー関連
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower

  # フレンド関連
  has_many :friend_relationships, -> { where friend: true },
                                     class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy

  has_many :friend_users, through: :friend_relationships, source: :followed


  def self.from_omniauth(auth)
    where(provider: auth["provider"], uid: auth["uid"]).first_or_create do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["name"]
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  # 他のユーザーをフォローする
  def follow(other_user)
    mine = following_relationships.find_or_create_by(followed_id: other_user.id)
    # フレンド設定、逆が存在したら
    other = follower_relationships.find_by(follower_id: other_user.id)
    if other
      mine.friend = true
      other.friend = true
      mine.save
      other.save
    end
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
    # フレンド解除、逆が存在したら
    other = follower_relationships.find_by(follower_id: other_user.id)
    if other
      other.friend = nil
      other.save
    end
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end

  # あるユーザーがフレンドになっているかどうか？
  def friend?(other_user)
    friend_users.include?(other_user)
  end
end
