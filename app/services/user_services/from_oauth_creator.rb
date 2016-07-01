module UserServices
  class FromOauthCreator
    include Concord.new(:auth)

    delegate :info, :provider, :uid, to: :auth
    delegate :email, :name, :nickname, to: :info

    def call
      user.skip_confirmation!
      user.save!
      user
    end

    private

    def generate_email
      "#{nickname || uid}@#{provider}_oauth.com"
    end

    def password
      @password ||= Devise.friendly_token.first(8)
    end

    def user
      @user ||= User.new(user_params)
    end

    def user_email
      email || generate_email
    end

    def user_params
      {
        email: user_email,
        full_name: name,
        password: password,
        password_confirmation: password
      }
    end
  end
end
