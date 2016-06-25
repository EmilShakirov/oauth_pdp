module IdentityServices
  class Recognizer
    include Concord.new(:auth)

    delegate :identities, :user, prefix: true
    delegate :info, :provider, :uid, to: :auth
    delegate :email, to: :info

    def call
      update_or_create_identity
      confirm_user
    end

    private

    def update_or_create_identity
      identity ? update_identity : create_identity
    end

    def identity
      @identity ||= Identity.from_omniauth(auth)
    end

    def update_identity
      identity.update_attribute(:user, user)
    end

    def create_identity
      user_identities.create!(provider: provider, uid: uid)
    end

    def confirm_user
      user.confirm if user.email == email
    end
  end
end
