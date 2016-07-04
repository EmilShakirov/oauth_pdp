module Omniauth
  DEFAULT_HASH = {
    provider: "facebook",
    uid: "123545",
    info: {
      email: "john_smith@example.com",
      name: "John Smith",
      nickname: "lucky-john"
    },
    extra: {
      raw_info: {
        email: "john_smith@example.com",
        name: "John Smith"
      }
    }
  }.freeze

  def auth_hash(verified: true)
    hash = DEFAULT_HASH.clone
    hash[:info][:verified] = verified
    hash[:extra][:raw_info][:verified] = verified
    OmniAuth::AuthHash.new(hash)
  end
end

RSpec.configure do |config|
  config.include Omniauth
end
