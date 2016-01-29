class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_mailer_host
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) { |u|
      u.permit(:email, :password, :password_confirmation, :current_password,
               :username, :description, :location, :url,
               :avatar, :avatar_cache, :remove_avatar,
               :bowel_public_level, :health_event_public_level,
               :share_post_public_level) }
  end
  
  private
  def set_mailer_host
    #ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
