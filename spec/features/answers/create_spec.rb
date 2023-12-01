require 'rails_helper'
require 'byebug'

describe 'user can create answer', "
  In order to reply to question
  As an authenticated user
  I'd like to be able to respond the question
" do

  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe 'Authenticated user' do
    before do
      login(user)
      visit question_path(question)
    end

    it 'responds a question', js: true do
      response_text = 'Lorem ipsum'

      fill_in 'Answer', with: response_text
      click_on 'Publish'
      visit question_path(question)

      expect(page).to have_content response_text
    end

    it 'created question without body', js: true do
      click_on 'Publish'
      expect(page).to have_content "Body can't be blank"
    end
  end

  describe 'Unauthenticated user' do
    it 'answers the question' do
      visit question_path(question)
      expect(page).not_to have_content 'Publish'
    end
  end
end
