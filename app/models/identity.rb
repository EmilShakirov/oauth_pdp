class Identity < ActiveRecord::Base
  PROVIDERS = %i(facebook twitter google_oauth2).freeze

  belongs_to :user

  validates :user, :provider, :uid, presence: true
  validates :uid, uniqueness: { scope: :provider }

  scope :by_provider_and_uid, ->(provider, uid) { where(provider: provider, uid: uid) }

  def self.from_omniauth(auth)
    find_by(provider: auth.provider, uid: auth.uid)
  end

  def self.generate_email(auth)
    "#{auth.info.nickname || auth.uid}@#{auth.provider}_oauth.com"
  end
end
