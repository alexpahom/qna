FactoryBot.define do
  sequence :email do |num|
    "example#{num}@test.com"
  end

  factory :user, aliases: [:author] do
    email
    password { 'qwerty' }
    password_confirmation { 'qwerty' }
  end
end
