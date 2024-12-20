class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_current_user
  
  private
  
  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
      Rails.logger.debug "Setting Current.user to #{Current.user&.email} (ID: #{session[:user_id]})"
    else
      Rails.logger.debug "No user_id in session"
      Current.user = nil
    end
  end
  
  def require_user_logged_in!
    unless Current.user
      flash[:alert] = "You must be signed in."
      redirect_to sign_in_path
    end
  end
end