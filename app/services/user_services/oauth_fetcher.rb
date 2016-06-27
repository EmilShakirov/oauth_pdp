module UserServices
  class OauthFetcher
    include Concord.new(:auth)

    def call
      user_from_omniauth || user_found_by_email || new_user
    end

    private

    def new_user
      UserServices::FromOauthCreator.new(auth).call
    end

    def user_found_by_email
      UserServices::ByEmailFinder.new(auth).call
    end

    def user_from_omniauth
      Identity.from_omniauth(auth)&.user
    end
  end
end
