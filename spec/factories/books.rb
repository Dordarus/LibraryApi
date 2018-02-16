require 'faker'
# spec/factories/items.rb
FactoryBot.define do
  factory :book do
    title { Faker::Book.unique.title }
    genre { Faker::Book.genre }
    year { rand(1850..2000) }
    plot { Faker::Lorem.sentence }
    author_id nil
  end
end