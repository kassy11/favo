# frozen_string_literal: true

FactoryBot.define do
  password = Faker::Internet.password(min_length: 8)
  factory :user do
    email { Faker::Internet.free_email }
    name { Faker::Name.name }
    password { password }
    password_confirmation { password }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }

    trait :with_fav_movies do
      after(:create) { |user| create_list(:movie, 5, user: user) }
    end

    trait :with_fav_books do
      after(:create) { |user| create_list(:book, 5, user: user) }
    end

    trait :with_fav_musics do
      after(:create) { |user| create_list(:music, 5, user: user) }
    end
  end
end
