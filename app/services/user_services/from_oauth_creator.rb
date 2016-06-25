module UserServices
  class FromOauthCreator
    include Concord.new(:auth)

    delegate :info, to: :auth
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

    def user_params
      {
        email: email,
        full_name: name,
        password: password,
        password_confirmation: password
      }
    end
  end
end
