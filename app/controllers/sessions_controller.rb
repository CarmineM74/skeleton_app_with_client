class SessionsController < ApplicationController
  respond_to :json
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user_from_token!, except: [:destroy]
  skip_before_filter :verify_session_freshness!

  def create
    @user = User.find_by_email(params[:user][:email])
    return failure('User not found',404) unless @user
    return failure unless @user.authenticate(params[:user][:password])
    @user.ensure_auth_token
    @user.save
    session[:expires_at] = AppConfig.session_duration.from_now 
    render status: 200,
      json: {
        success: true,
        info: 'authenticated',
        data: @user
      }
  end

  def destroy
    Rails.logger.info("Logging out #{current_user.inspect}")
    logout_current_user
    render status: 200,
      json: {
        success: true,
        info: 'logout',
        data: {}
      }
  end

end

