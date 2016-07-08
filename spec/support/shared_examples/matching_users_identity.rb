shared_examples_for "matching users identity" do
  it { expect(user_identity.uid).to eq auth_hash.uid }
  it { expect(user_identity.provider).to eq auth_hash.provider }
  it { expect(user_identity.user).to eq user }
  it { expect(user).to be_confirmed }
end
