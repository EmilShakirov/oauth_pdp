require "rails_helper"

describe IdentityServices::Recognizer do
  let(:auth_hash) { build(:omniauth_hash) }
  let(:service) { described_class.new(user, auth_hash) }
  let(:user_identity) { user.identities.reload.take }
  let(:user) { create(:user) }

  describe "#call" do
    context "when user has no existing identity" do
      before { service.call }

      it_behaves_like "matching users identity"
    end

    context "when user has identity" do
      let(:another_user) { create(:user) }

      before do
        Identity.destroy_all
        create :identity,
          uid: auth_hash.uid,
          provider: auth_hash.provider,
          user: another_user

        service.call
      end

      it_behaves_like "matching users identity"
    end
  end
end
