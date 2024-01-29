FactoryBot.define do
  factory :link do
    name { 'Test Link' }
    url { 'https://google.com' }

    trait :gist do
      url { 'https://gist.github.com/alexpahom/cb4813ca9b649fb2a567627c247c825e' }
    end
  end
end
