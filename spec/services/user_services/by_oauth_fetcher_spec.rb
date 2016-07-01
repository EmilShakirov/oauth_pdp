require "rails_helper"

describe UserServices::FromOauthFetcher do
  let(:service) { described_class.new(auth_hash) }

  describe "#call" do
    subject { service.call }

    context "user_from_omniauth" do
      let(:user) { create(:user) }
      let!(:identity) do
        create(:identity,
          provider: auth_hash.provider,
          uid: auth_hash.uid,
          user: user
        )
      end

      it { is_expected.to eq user }
    end

    context "user_found_by_email" do
      let!(:user) { create(:user, email: auth_hash.info.email) }

      it { is_expected.to eq user }
    end

    context "new_user" do
      let(:user) { User.last }

      before { subject }

      it { expect(user.email).to eq auth_hash.info.email }
      it { expect(user.full_name).to eq auth_hash.info.name }
    end
  end
end
