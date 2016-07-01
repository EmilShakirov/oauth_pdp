module Omniauth
  def auth_hash(verified: true)
    OmniAuth::AuthHash.new(
      provider: "facebook",
      uid: "123545",
      info: {
        email: "john_smith@example.com",
        name: "John Smith",
        nickname: "lucky-john",
        verified: verified
      },
      extra: {
        raw_info: {
          email: "john_smith@example.com",
          name: "John Smith",
          verified: verified
        }
      }
    )
  end
end

RSpec.configure do |config|
  config.include Omniauth
end
