module PublicLevelHelper
  LEVEL_DEFAULT = 0
  LEVEL_PRIVATE = 1
  LEVEL_FRIEND_SUMMARY = 2
  LEVEL_FRIEND = 3
  LEVEL_PUBLIC_SUMMARY = 4
  LEVEL_PUBLIC = 5

  PUBLIC_LEVEL_NAME = {
    PublicLevelHelper::LEVEL_DEFAULT => "既定値",
    PublicLevelHelper::LEVEL_PRIVATE => "非公開",
    PublicLevelHelper::LEVEL_FRIEND_SUMMARY => "フレンドのみ(概要)",
    PublicLevelHelper::LEVEL_FRIEND => "フレンドのみ",
    PublicLevelHelper::LEVEL_PUBLIC_SUMMARY => "公開(概要)",
    PublicLevelHelper::LEVEL_PUBLIC => "公開",
  }
  
  def public_level_list
    list = []
    [5, 3, 1].each do |n|
      list << [PUBLIC_LEVEL_NAME[n], n]
    end
    list
  end

  def min_public_level_for(current_user, other_user)
    return PublicLevelHelper::LEVEL_PUBLIC if current_user.nil? || other_user.nil?
    return PublicLevelHelper::LEVEL_DEFAULT if current_user.id == other_user.id
    return PublicLevelHelper::LEVEL_FRIEND_SUMMARY if current_user.friend?(other_user)
    return PublicLevelHelper::LEVEL_PUBLIC_SUMMARY
  end
end
