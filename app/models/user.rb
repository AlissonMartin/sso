class User < ApplicationRecord
  has_many :access_grants, dependent: :delete_all
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def oauth_payload
    _hash = {
      provider: "sso",
      id: self.id,
      info: {
        email: self.email,
        name: "name"
      }
    }
    return _hash
  end
end
