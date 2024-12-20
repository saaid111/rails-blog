class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      Rails.logger.debug "User logged in: #{user.email}"
      redirect_to root_path, notice: "Logged in successfully!"
    else
      Rails.logger.debug "Login failed for email: #{params[:email]}"
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    Rails.logger.debug "Logging out user: #{Current.user&.email}"
    session[:user_id] = nil
    Current.user = nil
    redirect_to root_path, notice: "Logged out!"
  end
end