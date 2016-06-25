module DynamicAuthProvider
  def current_auth_provider
    "AuthProviders::#{auth_provider}".constantize.new(auth)
  end
end
