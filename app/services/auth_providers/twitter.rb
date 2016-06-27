module AuthProviders
  class Twitter < Base
    def verified?
      true
    end
  end
end
