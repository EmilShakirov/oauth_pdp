module AuthProviders
  class FacebookAuthDecorator < BaseAuthDecorator
    def location
      info.location
    end

    def verified?
      info.verified? || extra.raw_info.verified?
    end
  end
end
