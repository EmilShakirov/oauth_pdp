class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include DynamicAuthProvider

  delegate :provider, to: :auth, prefix: true
  delegate :verified?, to: :current_auth_provider, prefix: :auth

  Identity::PROVIDERS.each do |provider|
    define_method(provider) do
      show_verification_notice && return unless auth_verified?

      current_user ? connect_identity : signing_in
    end
  end

  private

  def auth
    @auth ||= request.env["omniauth.auth"]
  end

  def connect_identity
    IdentityServices::Recognizer.call(current_user, auth)

    redirect_to edit_user_registration_path
  end

  def show_verification_notice
    redirect_to root_path, flash: { error: "Your social account is not verified." }
  end

  def signing_in
    sign_in_and_redirect user_from_auth, event: :authentication
  end

  def user_from_auth
    UserServices::FromOauthFetcher.call(current_auth_provider)
  end
end
