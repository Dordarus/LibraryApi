FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      email 'some@email.com'
      password 'password'
    end
  end