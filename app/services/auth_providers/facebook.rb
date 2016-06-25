module AuthProviders
  class Facebook < Base
    def verified?
      info.verified? || extra.raw_info.verified?
    end
  end
end
