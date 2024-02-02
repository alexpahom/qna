require 'rails_helper'

describe 'user can reverse vote for question/answer', %{
  In order to get reverse vote for question/answer
  As an authenticated user
  I'd like to be able to reverse vote
} do

  describe 'Question' do
    let(:question) { create(:question) }
    let(:user) { create(:user) }

    before do
      login(user)
      visit question_path(question)
    end

    it 'Can reverse vote for', js: true do
      within('.rank-wrapper') do |node|
        click_on '+'
        expect(node).to have_content('Rank: 0')
      end
    end

    it 'Can reverse vote against', js: true do
      within('.rank-wrapper') do |node|
        click_on '-'
        expect(node).to have_content('Rank: 0')
      end
    end
  end

  describe 'Answer' do
    let(:question) { create(:question, :answered) }
    let(:user) { question.author }

    before do
      login(user)
      visit question_path(question)
    end

    it 'Can reverse vote for', js: true do
      within(:xpath, first_answer_xpath) do
        init = question.answers.first.ranking
        click_on '+'
        click_on '+'
        sleep 0.1
        expect(question.answers.first.ranking).to eq(init)
      end
    end

    it 'Can reverse vote against', js: true do
      within(:xpath, first_answer_xpath) do
        init = question.answers.first.ranking
        click_on '-'
        click_on '-'
        sleep 0.1
        expect(question.answers.first.ranking).to eq(init)
      end
    end
  end
end
