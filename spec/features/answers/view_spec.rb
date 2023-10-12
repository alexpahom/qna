require 'rails_helper'

describe 'user can see answers', "
  In order to see answers to a question
  As an authenticated user
  I'd like to be able to see the answers
" do

  let(:user) { create(:user) }
  let(:question) { create(:question, :with_answers) }

  describe 'Authenticated user' do
    before do
      login(user)
      visit question_path(question)
    end

    it 'can view answers to the question' do
      answer1, answer2 = question.answers

      expect(page).to have_content answer1.body
      expect(page).to have_content answer2.body
    end
  end

  it 'Unauthenticated user opens the answers' do
    visit question_path(question)

    answer1, answer2 = question.answers

    expect(page).to have_content answer1.body
    expect(page).to have_content answer2.body
  end
end