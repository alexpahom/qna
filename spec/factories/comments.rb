FactoryBot.define do
  factory :comment do
    body { 'Looks good' }
    author { create(:user) }
  end
end
