FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email(nickname) }
    nickname { Faker::Internet.username(5..8) }
    password { 'asdfasdf' }
  end
end
