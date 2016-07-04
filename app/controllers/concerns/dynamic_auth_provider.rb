module DynamicAuthProvider
  def current_auth_provider
    "AuthProviders::#{auth_provider.to_s.classify}AuthDecorator".constantize.new(auth)
  end
end
