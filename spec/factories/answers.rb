FactoryBot.define do
  factory :answer do
    body { "MyText" }
    association :question
  end

  trait :invalid do
    body { nil }
  end
end
