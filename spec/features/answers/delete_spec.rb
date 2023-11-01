require 'rails_helper'

describe 'user can delete their answers', "
  In order delete my own answer
  As an authenticated user
  I'd like to be able to delete my answer
" do

  let(:user) { create(:user) }
  let(:question) { create(:question, :answered) }
  let(:answer_text) { 'Lorem Ipsum' }

  before do
    login(user)
    visit question_path(question)
  end

  describe 'Delete answer' do
    it 'deletes user\'s own answer', xhr: true do
      fill_in 'Answer', with: answer_text
      click_on 'Publish'
      click_on 'Delete'
      expect(page).not_to have_content answer_text
    end
  end

  describe 'Unsuccessful delete' do
    it 'cannot delete another user\'s question' do
      expect(page).not_to have_content 'Delete'
    end
  end
end
