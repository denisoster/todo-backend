FactoryBot.define do
  factory :task do
    title { Faker::Lebowski.character }
    status { [true, false].sample }
    deadline { Faker::Time.between(Time.current, Time.current + 3.weeks) }
    project
  end
end
