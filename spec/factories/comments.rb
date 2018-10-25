FactoryBot.define do
  factory :comment do
    description { Faker::Lebowski.quote }
    task
    attachment do
      Rack::Test::UploadedFile.new(Rails.root.join('public', 'images', 'demo.jpg'),
                                   'image/jpeg')
    end
  end
end
