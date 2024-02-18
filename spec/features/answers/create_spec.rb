require 'rails_helper'

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

    it 'attaches files to the answer', js: true do
      response_text = 'test response'

      fill_in 'Answer', with: response_text
      attach_file 'Attach', ["#{Rails.root.join('spec/rails_helper.rb')}", "#{Rails.root.join('spec/spec_helper.rb')}"]
      click_on 'Publish'

      refresh # TODO: requires js-template builder
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
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

  describe 'Realtime answer rendering' do
    it '2nd user can see answer is created' do
      Capybara.using_session(:guest) do
        visit question_path(question)
      end

      response_text = 'Test Answer'

      Capybara.using_session(:user) do
        login(user)
        visit question_path(question)
        fill_in 'Answer', with: response_text
        click_on 'Publish'
        expect(page).to have_content response_text
      end

      Capybara.using_session(:guest) do
        expect(page).to have_content response_text
      end
    end
  end
end
