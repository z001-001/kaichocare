module UsersHelper

  def avatar_for(user, option = { size: 80})
    size = option[:size]
    if user.avatar.url.present?
      image_tag(user.avatar.url, alt: user.username, class: "avatar img-thumbnail",
                :size => "#{size}x#{size}")
    else
      image_tag("default-avatar.png", alt: user.username, class: "avatar img-thumbnail",
                :size => "#{size}x#{size}")
    end
  end
  
  def feeling_image_for(model)
    if model.feeling.present?
      feeling = model.feeling
      alt_str = case feeling
      when "1" then "良好"
      when "2" then "まずまず"
      when "3" then "悪い"
      else ""
      end
      image_tag "feeling_#{feeling}.png", alt: alt_str
    else
      ""
    end
  end
  
  def stool_image_for(model)
    if model.color
      style_str = "background-color: ##{model.color};"
    else
      style_str = ""
    end
    if model.shape
      fname = "shape_#{model[:shape]}_#{model.shape}.png"
      alt_str = model.shape.humanize
      image_tag fname, alt: alt_str, style: style_str
    else
      ""
    end
  end
  
  def stool_amount_for(model)
    case model.amount
    when 0..1 then "(少)"
    when 2, 3 then ""
    when 4, 5 then "(多)"
    else ""
    end
  end
end
