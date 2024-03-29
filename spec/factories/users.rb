FactoryBot.define do
  sequence :email do |num|
    "test#{num}@test.com"
  end

  factory :user, aliases: [:author] do
    email
    password { 'qwerty' }
    password_confirmation { 'qwerty' }
    confirmed_at { Time.zone.now }
  end
end
