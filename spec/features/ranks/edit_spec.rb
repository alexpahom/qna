require 'rails_helper'

describe 'user can change vote for question/answer', %{
  In order to get change vote for question/answer
  As an authenticated user
  I'd like to be able to change vote
} do

  describe 'Question' do
    let(:question) { create(:question) }
    let(:user) { create(:user) }

    before do
      login(user)
      visit question_path(question)
    end

    it 'Can change the vote from up to against', js: true do
      within('.rank-wrapper') do |node|
        click_on '+'
        click_on '-'
        expect(node).to have_content('Rank: -1')
      end
    end

    it 'Can change the vote from against to up', js: true do
      within('.rank-wrapper') do |node|
        click_on '-'
        click_on '+'
        expect(node).to have_content('Rank: 1')
      end
    end
  end

  describe 'Answer' do
    let(:question) { create(:question, :answered_ranked) }
    let(:user) { question.author }

    before do
      login(user)
      visit question_path(question)
    end

    it 'Can change the vote fom up to against', js: true do
      within('.rank-wrapper') do |node|
        click_on '+'
        click_on '-'
        expect(node).to have_content("Rank: #{question.answers.first.ranking}")
      end
    end

    it 'Can change the vote from against to up', js: true do
      within('.rank-wrapper') do |node|
        click_on '-'
        click_on '+'
        expect(node).to have_content("Rank: #{question.answers.first.ranking}")
      end
    end
  end
end