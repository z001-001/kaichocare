module UsersHelper
  #def gravatar_for(user, option = { size: 80})
  #  gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
  #  size = option[:size]
  #  gravatar_url ="https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  #  image_tag(gravatar_url, alt: user.username, class: "gravatar")
  #end

  def avatar_for(user, option = { size: 80})
    size = option[:size]
    if user.avatar.url.present?
      image_tag(user.avatar.url, alt: user.username, class: "gravatar",
                :size => "#{size}x#{size}")
    else
      image_tag("default-avatar.png", alt: user.username, class: "gravatar",
                :size => "#{size}x#{size}")
    end
  end
end
