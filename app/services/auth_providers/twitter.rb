module AuthProviders
  class Twitter < Base
    delegate :credentials, to: :auth

    def verified?
      credentials.token
    end
  end
end
