require 'rails_helper'

describe 'user can edit his answer', "
  In order correct existing answer
  As an authenticated user
  I'd like to be able to edit the answer
" do

  let!(:question) { create(:question, :answered) }
  let!(:answer_to_edit) { question.answers.first }

  describe 'Authenticated user' do
    before do
      login(answer_to_edit.author)
      visit question_path(question)
      click_on 'Edit'
    end

    it 'responds a question', js: true do
      new_answer_text = 'qwerty'

      within("#edit_form_#{answer_to_edit.id}") do |node|
        node.fill_in 'Respond', with: new_answer_text
        node.click_on 'Update'
      end

      within("#answer_#{answer_to_edit.id}") do |node|
        expect(node).to have_content new_answer_text
      end
    end

    it 'edits question with errors', js: true do
      within("#edit_form_#{answer_to_edit.id}") do |node|
        node.fill_in 'Respond', with: ''
        node.click_on 'Update'
      end

      expect(page).to have_content "Body can't be blank"
    end
  end

  describe 'Unauthenticated user' do
    it 'responds to a question' do
      visit question_path(question)

      expect(page).not_to have_content 'Publish'
    end
  end
end
