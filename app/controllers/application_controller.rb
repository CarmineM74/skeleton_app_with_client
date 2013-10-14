class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  after_filter :set_csrf_for_angular
  before_filter :authenticate_user_from_token!

private

  # AngularJs CSRF stuff
  def set_csrf_for_angular
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def verified_request?
    csrf_token = request.headers['HTTP_X_XSRF_TOKEN']
    super || form_authenticity_token == csrf_token
  end

  def failure(message='Authentication required', status = 401)
    warden.custom_failure!
    render status: status,
      json: {
        success: false,
        info: message,
        data: {}
      }
  end

  def authenticate_user_from_token!
    authenticate_with_http_token do |token, options|
      Rails.logger.info("Token: #{token}\nOptions: #{options}")
      user = User.find_by_auth_token(token)
      if user && Devise.secure_compare(user.auth_token, token)
        sign_in user
      else
        return failure
      end
    end
  end

end
