module AuthProviders
  class BaseAuthDecorator < Draper::Decorator
    delegate_all

    def location
      "N/A"
    end
  end
end
