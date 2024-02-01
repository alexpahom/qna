FactoryBot.define do
  factory :answer do
    body { "MyText" }
    association :question
    association :author
  end

  trait :invalid do
    body { nil }
  end

  trait :ranked do
    after(:create) do |question|
      create_list(:rank, 5, rankable: question)
    end
  end
end
