class Identity < ActiveRecord::Base
  PROVIDERS = %i(facebook).freeze

  belongs_to :user

  validates :user, :provider, :uid, presence: true
  validates :uid, uniqueness: { scope: :provider }

  scope :by_provider_and_uid, ->(provider, uid) { where(provider: provider, uid: uid) }

  def self.from_omniauth(auth)
    find_by(provider: auth.provider, uid: auth.uid)
  end
end
