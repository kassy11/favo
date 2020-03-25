FactoryBot.define do
  factory :music do
    association :user
    artist_id {Faker::Internet.uuid}
  end
end