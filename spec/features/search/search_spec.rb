require 'sphinx_helper'

feature 'Search', %{
  In order to be able to look for information faster
  As a user
  I'd like to be able to perform search
} do

  describe 'search in', js: true, sphinx: true do
    let!(:questions) { create_list(:question, 5) }
    let!(:question) { questions.sample }

    let!(:comments) { create_list(:comment, 5, commentable: question) }
    let!(:comment) { comments.sample }

    let!(:answers) { create_list(:answer, 5, question: question) }
    let!(:answer) { answers.sample }

    let!(:user) { create(:user) }

    before { visit root_path }

    it 'question' do
      ThinkingSphinx::Test.run do
        select 'Question', from: 'scope'
        fill_in 'query', with: question.title

        click_on 'Search'

        within('.results-wrapper') do |node|
          expect(node).to have_content question.title
        end
      end
    end

    it 'answer' do
      ThinkingSphinx::Test.run do
        select 'Answer', from: 'scope'
        fill_in 'query', with: answer.body

        click_on 'Search'

        within('.results-wrapper') do |node|
          expect(node).to have_content answer.body
        end
      end
    end

    it 'comment' do
      ThinkingSphinx::Test.run do
        select 'Comment', from: 'scope'
        fill_in 'query', with: comment.body

        click_on 'Search'

        within('.results-wrapper') do |node|
          expect(node).to have_content comment.body
        end
      end
    end

    it 'user' do
      ThinkingSphinx::Test.run do
        select 'User', from: 'scope'
        fill_in 'query', with: user.email

        click_on 'Search'

        within('.results-wrapper') do |node|
          expect(node).to have_content user.email
        end
      end
    end

    it 'everywhere' do
      ThinkingSphinx::Test.run do
        select 'Everywhere', from: 'scope'
        fill_in 'query', with: user.email

        click_on 'Search'

        within('.results-wrapper') do |node|
          expect(node).to have_content user.email
        end
      end
    end

    it 'blank' do
      ThinkingSphinx::Test.run do
        select 'Everywhere', from: 'scope'

        click_on 'Search'

        within('.results-wrapper') do |node|
          expect(node).to have_content comment.body
          expect(node).to have_content answer.body
          expect(node).to have_content question.title
        end
      end
    end
  end
end
