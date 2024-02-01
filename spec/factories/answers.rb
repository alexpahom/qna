FactoryBot.define do
  factory :answer do
    body { "MyText" }
    association :question
    association :author
  end

  trait :invalid do
    body { nil }
  end
end
