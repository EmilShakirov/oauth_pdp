FactoryGirl.define do
  factory :identity do
    provider { "facebook" }
    uid { SecureRandom.hex }
    user
  end
end
