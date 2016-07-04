module UserServices
  class FromOauthCreator
    include Concord.new(:auth)

    delegate :info, :provider, :uid, :location, to: :auth
    delegate :email, :name, to: :info

    def call
      user.skip_confirmation!
      user.save!
      user
    end

    private

    def password
      @password ||= Devise.friendly_token.first(8)
    end

    def user
      @user ||= User.new(user_params)
    end

    def user_email
      email || Identity.generate_email(auth)
    end

    def user_params
      {
        email: user_email,
        full_name: name,
        location: location,
        password: password,
        password_confirmation: password
      }
    end
  end
end
