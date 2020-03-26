# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    association :user
    movie_id { Faker::Internet.uuid }
    movie_name { Faker::Name.name }
  end
end
