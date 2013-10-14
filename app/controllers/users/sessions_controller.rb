class Users::SessionsController < Devise::SessionsController

  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user_from_token!, except: [:destroy]

  def create
    render status: 200,
      json: {
        success: true,
        info: 'authenticated',
        data: { 
          email: 'test@me.com',
          name: 'The big fake Co',
          auth_token: 'ItSAFakeTokenFromServer1974'
        }
      }
  end

  def destroy
    render status: 200,
      json: {
        success: true,
        info: 'logout',
        data: {}
      }
  end

end

