class UsersController < ApplicationController
  respond_to :json
  
  def index
    render status: 200, json: User.all() 
  end

  def show
    render status: 200, json: { success: true, info: 'NOT IMPLEMENTED', data: {}}
  end

  def create
    render status: 200, json: { success: true, info: 'NOT IMPLEMENTED', data: {}}
  end

  def update
    render status: 200, json: { success: true, info: 'NOT IMPLEMENTED', data: {}}
  end

  def destroy
    render status: 200, json: { success: true, info: 'NOT IMPLEMENTED', data: {}}
  end

end
