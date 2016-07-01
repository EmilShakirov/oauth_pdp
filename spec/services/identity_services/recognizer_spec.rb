require "rails_helper"

describe IdentityServices::Recognizer do
  let(:service) { described_class.new(user, auth_hash) }
  let(:user) { create(:user) }

  describe "#call" do
    context "when user has no existing identity" do
      let(:created_identity) { Identity.last }

      before { service.call }

      it { expect(created_identity.uid).to eq auth_hash.uid }
      it { expect(created_identity.provider).to eq auth_hash.provider }
      it { expect(created_identity.user).to eq user }
      it { expect(user.confirmed?).to eq true }
    end

    context "when user has identity" do
      let(:another_user) { create(:user) }
      let(:identity) do
        create(
          :identity,
          uid: auth_hash.uid,
          provider: auth_hash.provider,
          user: another_user
        )
      end

      before do
        allow(service).to receive(:identity).and_return(identity)
        service.call
      end

      it { expect(identity.user).to eq user }
      it { expect(user.confirmed?).to eq true }
    end
  end
end
