class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  after_filter :set_csrf_for_angular
  before_filter :authenticate_user_from_token!
  before_filter :verify_session_freshness!

  helper_method :current_user

protected

  def current_user
    @current_user || nil
  end

  def logout_current_user
    current_user.auth_token = nil
    current_user.save
    current_user = nil
  end

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
    render status: status,
      json: {
        success: false,
        info: message,
        data: {}
      }
  end

  def verify_session_freshness!
    return failure('Missing session data') unless session[:expires_at]
    if Time.now >= session[:expires_at]
      Rails.logger.info("*** SESSION IS EXPIRED ****")
      logout_current_user
      return failure('Session is expired!')
    end
  end

  def authenticate_user_from_token!
    @current_user = nil
    Rails.logger.info("Authenticating user from token ...")
    Rails.logger.info("Session: #{session.inspect}")
    authenticate_with_http_token do |token, options|
      Rails.logger.info("Token: #{token}\nOptions: #{options}")
      @current_user = User.find_by_auth_token(token)
    end
    return failure unless current_user
  end

end
