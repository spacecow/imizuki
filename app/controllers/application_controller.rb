class ApplicationController < ActionController::Base
  include BasicApplicationController

  protect_from_forgery
  helper_method :jt

  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = alertify(:unauthorized_access)
    flash[:alert] = exception.message
    if current_user
      redirect_to welcome_url
    else
      session_original_url(request.path)
      redirect_to login_url
    end
  end

  def alert(act); t("alert.#{act}") end
  def ft(s); t("formtastic.labels.#{s.to_s}") end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

    def authenticate
      unless current_user || Rails.env.test?
        authenticate_or_request_with_http_basic do |username,password|
          @user = User.authenticate(username,password)
          session[:user_id] = @user.id if @user
        end
      end
    end
end
