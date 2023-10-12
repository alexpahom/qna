require 'rails_helper'

describe 'user can see questions', "
  In order to get a list of available questions
  As an user
  I'd like to be able to see questions
" do

  let!(:question) { create(:question, :answered) }

  describe 'Authenticated user' do
    it 'can see the list of questions' do
      login(question.author)
      visit questions_path

      expect(page).to have_content question.body
      expect(page).to have_content question.title
    end
  end

  describe 'Unauthenticated user' do
    it 'can see the list of questions' do
      visit questions_path

      expect(page).to have_content question.body
      expect(page).to have_content question.title
    end
  end
end
