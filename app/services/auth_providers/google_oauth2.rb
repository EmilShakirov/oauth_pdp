module AuthProviders
  class GoogleOauth2 < Base
    def verified?
      extra.raw_info.email_verified?
    end
  end
end
