FactoryBot.define do
  factory :answer do
    body { "MyText" }
    association :question
    association :author
  end

  trait :invalid do
    body { nil }
  end

  trait :commented do
    after(:create) do |answer|
      create_list(:comment, 1, commentable: answer)
    end
  end

  trait :with_attachments do
    after(:create) do |answer|
      answer.files.attach(io: File.open("#{Rails.root}/Gemfile"), filename: 'Gemfile')
    end
  end
end
