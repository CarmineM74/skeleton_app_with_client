class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true

  def ensure_auth_token
    self.auth_token = generate_auth_token! #if self.auth_token.blank?
  end

private

  def generate_auth_token!
    loop do
      token = Digest::SHA1.hexdigest([Time.now,rand].join)
      break token unless User.find_by_auth_token(token)
    end
  end
end
