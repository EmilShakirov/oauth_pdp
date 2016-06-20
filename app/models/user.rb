class User < ActiveRecord::Base
  devise :confirmable,
    :database_authenticatable,
    :omniauthable,
    :recoverable,
    :registerable,
    :rememberable,
    :trackable,
    :validatable,
    omniauth_providers: Identity::PROVIDERS

  validates :full_name, presence: true
end
