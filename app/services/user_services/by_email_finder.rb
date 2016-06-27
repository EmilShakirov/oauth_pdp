module UserServices
  class ByEmailFinder
    include Concord.new(:auth)

    delegate :identities, to: :user, prefix: true
    delegate :info, :provider, :uid, to: :auth
    delegate :email, to: :info

    def call
      return unless user

      create_identity
      user.confirm unless user.confirmed?
      user
    end

    private

    def create_identity
      user_identities
        .by_provider_and_uid(provider, uid)
        .first_or_create!
    end

    def user
      @user ||= User.find_by(email: email)
    end
  end
end
