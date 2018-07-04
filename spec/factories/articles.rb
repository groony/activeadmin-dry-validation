FactoryBot.define do
  factory :article do
    title { Faker::Name.title }
    announcement { Faker::Lorem.sentence }
  end
end
