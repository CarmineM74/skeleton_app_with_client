class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :trackable, :timeoutable 

  def ensure_auth_token
    self.auth_token = generate_auth_token! if self.auth_token.blank?
  end

private
  
  def generate_auth_token!
    loop do
      token = Devise.friendly_token
      break token unless User.find_by_auth_token(token)
    end
  end

end
