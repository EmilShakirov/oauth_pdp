class Identity < ActiveRecord::Base
  PROVIDERS = %i(facebook).freeze

  belongs_to :user

  validates :user, :provider, :uid, presence: true
  validates :uid, uniqueness: { scope: :provider }
end
