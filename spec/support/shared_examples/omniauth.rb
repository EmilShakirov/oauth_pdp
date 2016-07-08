shared_context :stub_omniauth do
  background do
    OmniAuth.config.mock_auth[:facebook] = FactoryGirl.build(:omniauth_hash)
  end
end

shared_context :stub_not_verified_omniauth do
  background do
    OmniAuth.config.mock_auth[:facebook] = FactoryGirl.build(:omniauth_hash, :not_verified)
  end
end
