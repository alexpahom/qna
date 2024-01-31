require 'rails_helper'

describe 'User can add badge to question', %{
  In order to add badge to my question
  As a question's author
  I'd like to be able to add the badge
} do
  let(:user) { create(:user) }

  it 'User can create a badge' do
    login(user)
    visit new_question_path

    description = 'image description'

    fill_in 'Title', with: 'test title'
    fill_in 'Body', with: 'test body'
    fill_in 'Description', with: description
    attach_file 'Badge Image', "#{Rails.root.join('spec/rails_helper.rb')}"

    click_on 'Publish'
    within('#reward') do |reward_section|
      expect(reward_section).to have_content description
      expect(reward_section).to have_css('img[src$="rails_helper.rb"]')
    end
  end
end
