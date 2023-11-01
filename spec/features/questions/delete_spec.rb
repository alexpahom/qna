require 'rails_helper'

describe 'user can delete their questions', "
  In order delete my own question
  As an authenticated user
  I'd like to be able to delete my question
" do

  let(:user) { create(:user) }
  let(:question) { create(:question, :answered) }

  describe 'Delete question' do
    it 'deletes user\'s own question', xhr: true do
      login(question.author)
      visit questions_path
      click_on 'Delete'
      expect(page).not_to have_content question.title
    end
  end

  describe 'Unsuccessful delete' do
    it "delete is not available for some one else's question" do
      login(user)
      visit questions_path
      expect(page).not_to have_content 'Delete'
    end
  end
end
