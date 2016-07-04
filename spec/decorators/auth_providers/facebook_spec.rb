require "rails_helper"

describe AuthProviders::FacebookAuthDecorator do
  let(:service) { described_class.new(auth) }

  describe "#verified?" do
    subject { service.verified? }

    context "verifiing with info" do
      let(:auth) do
        OmniAuth::AuthHash.new(info: { verified: true })
      end

      it { is_expected.to be_truthy }
    end

    context "verifiing with  extra.raw_info" do
      let(:auth) do
        OmniAuth::AuthHash.new(info: {}, extra: { raw_info: { verified: true } })
      end

      it { is_expected.to be_truthy }
    end

    context "not verified" do
      let(:auth) do
        OmniAuth::AuthHash.new(info: { verified: false }, extra: { raw_info: {} })
      end

      it { is_expected.to eq false }
    end
  end
end
