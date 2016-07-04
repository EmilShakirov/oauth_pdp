module AuthProviders
  class GoogleOauth2AuthDecorator < BaseAuthDecorator
    def verified?
      extra.raw_info.email_verified?
    end
  end
end
