module AuthProviders
  class TwitterAuthDecorator < BaseAuthDecorator
    delegate :location, to: :info

    def verified?
      credentials.token
    end
  end
end
