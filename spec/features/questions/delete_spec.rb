require 'rails_helper'

describe 'user can delete their questions', "
  In order delete my own question
  As an authenticated user
  I'd like to be able to delete my question
" do

  let(:user) { create(:user) }
  let(:question) { create(:question, :answered) }
  let(:filepaths) { create(question.files.map(&:filename)) }

  describe 'Delete question' do
    it 'deletes user\'s own question', js: true do
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

  describe 'Delete attachment' do
    it 'can delete attachment', js: true do
      login(question.author)
      visit question_path(question.id)

      filepaths.each do |filename|
        find_link(id: "delete_attachment_#{filename}").click
        expect(page).not_to have_content filename
      end
    end
  end
end
