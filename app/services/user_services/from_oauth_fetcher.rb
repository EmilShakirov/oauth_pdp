module UserServices
  class FromOauthFetcher
    include Concord.new(:auth)
    include Procto.call

    def call
      user_from_omniauth || user_found_by_email || new_user
    end

    private

    def new_user
      UserServices::FromOauthCreator.call(auth)
    end

    def user_found_by_email
      UserServices::ByEmailFinder.call(auth)
    end

    def user_from_omniauth
      Identity.from_omniauth(auth)&.user
    end
  end
end
