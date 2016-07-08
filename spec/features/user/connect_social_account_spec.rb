require "rails_helper"

feature "Connect social account" do
  let(:auth_hash) { build(:omniauth_hash) }
  let!(:user) { create(:user, email: auth_hash.info.email) }

  subject(:click_connect_fb) do
    login_as(user, scope: :user)
    visit edit_user_registration_path(user)
    click_link "Facebook"
  end

  context "oauth confirmed" do
    include_context :stub_omniauth

    scenario "User connects social account" do
      click_connect_fb
      expect(page).to have_text("Disconnect facebook")
    end
  end

  context "oauth not confirmed" do
    include_context :stub_not_verified_omniauth

    scenario "User views alert message" do
      click_connect_fb
      expect(page).to have_text("Your social account is not verified.")
    end
  end
end
