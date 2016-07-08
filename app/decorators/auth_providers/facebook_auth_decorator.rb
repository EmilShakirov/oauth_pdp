module AuthProviders
  class FacebookAuthDecorator < BaseAuthDecorator
    delegate :location, to: :info

    def verified?
      info.verified? || extra.raw_info.verified?
    end
  end
end
