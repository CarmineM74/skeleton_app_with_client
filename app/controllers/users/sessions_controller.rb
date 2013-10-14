class Users::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user_from_token!, except: [:destroy]

  def create
    @user = User.find_for_database_authentication(email: params[:user][:email])
    return failure('User not found',404) unless @user
    return failure unless @user.valid_password?(params[:user][:password])
    @user.ensure_auth_token
    @user.save
    sign_in @user
    render status: 200,
      json: {
        success: true,
        info: 'authenticated',
        data: @user
      }
  end

  def destroy
    Rails.logger.info("Logging out #{current_user.inspect}")
    render status: 200,
      json: {
        success: true,
        info: 'logout',
        data: {}
      }
  end

end

