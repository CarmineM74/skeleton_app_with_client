class UsersController < ApplicationController
  respond_to :json
  skip_before_filter :authenticate_user_from_token!, only: [:create]
  skip_before_filter :verify_session_freshness!, only: [:create]
  before_filter :find_user, except: [:index,:create]
  
  def index
    render status: 200, json: User.all() 
  end

  def show
    render status: 200, json: { success: true, info: 'NOT IMPLEMENTED', data: {}}
  end

  def create
    return failure('User already exists', :unprocessable_entity) if User.find_by_email(params[:user][:email])
    user = User.new(create_params)
    if user.save
      render status: 201,
        json: {
          success: true,
          info: 'user created',
          data: user
        }
    else
      render status: :unprocessable_entity,
        json: {
          success: false,
          info: 'could not create user',
          data: user.errors
        }
    end
  end

  def update
    render status: 200, json: { success: true, info: 'NOT IMPLEMENTED', data: {}}
  end

  def destroy
    if @user.destroy
      render status: :ok,
        json: {
          success: true,
          info: "User deleted",
          data: {}
      }
    else
      return failure("Cannot delete user", :unprocessable_entity)
    end
  end

private

  def create_params
    params.require(:user).permit!
  end

  def find_user
    @user = User.find(params[:id])
  end

end
