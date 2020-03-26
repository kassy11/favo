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
  end
end
