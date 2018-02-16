require 'faker'
# spec/factories/todos.rb
FactoryBot.define do
  factory :author do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    bio {Faker::Lorem.sentences}
  end
end