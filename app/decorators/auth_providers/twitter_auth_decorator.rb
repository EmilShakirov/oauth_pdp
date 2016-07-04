module AuthProviders
  class TwitterAuthDecorator < BaseAuthDecorator
    def location
      info.location
    end

    def verified?
      credentials.token
    end
  end
end
