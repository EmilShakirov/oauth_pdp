require "rails_helper"

describe AuthProviders::Twitter do
  let(:service) { described_class.new(auth) }

  describe "#verified?" do
    subject { service.verified? }

    context "info" do
      let(:auth) do
        OmniAuth::AuthHash.new(credentials: { token: "12345", secret: "ABCDEF" })
      end

      it { is_expected.to be_truthy }
    end
  end
end
