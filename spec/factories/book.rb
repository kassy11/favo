FactoryBot.define do
  factory :book do
    association :user
    book_id {Faker::Internet.uuid}
    book_name {Faker::Book.title}
  end
end