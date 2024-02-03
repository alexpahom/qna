require 'rails_helper'

describe 'User can create a comment for question/answer', %{
  In order to react on a question/answer
  As an authenticated user
  I should be able to create a comment for question/answer
} do

  let(:question) { create(:question, :answered) }
  let(:user) { create(:user) }

  context 'Authenticated user' do

    before do
      login(user)
      visit questions_path(question)
    end

    it 'Create comment for question' do
      test_comment = 'Test comment'

      click_on 'Comment'
      fill 'Content', with: test_comment
      click_on 'Add'

      expect(page).to have_content test_comment
    end

    it 'Create comment for answer' do
      test_comment = 'Test comment answer'
      within(:xpath, first_answer_xpath) do |node|
        fill 'Content', with: test_comment
        click_on 'Add'

        expect(node).to have_content test_comment
      end
    end
  end

  context 'Unauthenticated user' do

    before { visit questions_path(question) }

    it 'Cannot create comment for question' do

      expect(page).not_to have_selector('.add-comment')
    end

    it 'cannot create comment for answer' do
      within(:xpath, first_answer_xpath) do |node|
        expect(node).not_to have_selector('.add-comment')
      end
    end
  end
end
