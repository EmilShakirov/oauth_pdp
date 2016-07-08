require "rails_helper"

describe UserServices::FromOauthCreator do
  let(:auth_hash) { build(:omniauth_hash) }
  let(:service) { described_class.new(auth_hash) }

  describe "#call" do
    context "when auth hash email present" do
      before { service.call }

      let(:user) { User.find_by_email(auth_hash.info.email) }

      it { expect(user).to be_truthy }
    end

    context "when auth hash has no email" do
      let(:user) { User.last }
      let(:generated_email) do
        "#{auth_hash.info.nickname}@#{auth_hash.provider}_oauth.com"
      end

      before do
        allow(service).to receive_message_chain(:email).and_return(false)
        service.call
      end

      it { expect(user.email).to eq generated_email }
    end
  end
end
