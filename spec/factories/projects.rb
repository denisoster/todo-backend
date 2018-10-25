FactoryBot.define do
  factory :project do
    title { Faker::Lebowski.quote }
    user
  end
end
