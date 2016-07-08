FactoryGirl.define do
  factory :omniauth_hash, class: OmniAuth::AuthHash do
    skip_create

    verified true

    initialize_with do
      OmniAuth::AuthHash.new(provider: "facebook",
                             uid: "123123",
                             info: {
                               email: "john_smith@example.com",
                               name: "John Smith",
                               nickname: "lucky-john",
                               verified: verified
                             },
                             extra: {
                               raw_info: {
                                 email: "john_smith@example.com",
                                 name: "John Smith",
                                 verified: verified
                               }
                             })
    end

    trait :not_verified do
      initialize_with do
        FactoryGirl.build(:omniauth_hash, verified: false)
      end
    end
  end
end
