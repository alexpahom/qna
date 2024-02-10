FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
    association :author

    trait :invalid do
      title { nil }
    end

    trait :answered do
      after(:create) do |question|
        create_list(:answer, 3, question: question)
      end
    end

    trait :with_attachments do
      files do
        [
          Rack::Test::UploadedFile.new("#{Rails.root.join('spec/rails_helper.rb')}"),
          Rack::Test::UploadedFile.new("#{Rails.root.join('spec/spec_helper.rb')}")
        ]
      end
    end

    trait :with_gist do
      after(:create) do |question|
        create(:link, linkable: question)
      end
    end

    trait :commented do
      after(:create) do |question|
        create_list(:comment, 1, commentable: question)
      end
    end
  end
end
