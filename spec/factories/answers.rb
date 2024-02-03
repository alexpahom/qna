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
      create_list(:comment, 2, commentable: answer)
    end
  end
end
