require 'rails_helper'

feature 'User can add links to answer', %{
  In order to provide additional info to answer
  As question's author
  I'd like to be able to add links
} do

  let(:user) { create(:user) }
  let!(:question) { create(:question) }
  let(:gist_url) { 'https://gist.github.com/alexpahom/cb4813ca9b649fb2a567627c247c825e' }
  let(:gist_github_title) { 'gist_sample' }

  before do
    login(user)
    visit question_path(question)
    fill_in 'Answer', with: 'text'
  end

  it 'User add links when leaves answer', js: true do
    fill_in 'Answer', with: 'test answer'

    fill_in 'Link name', with: 'Google'
    fill_in 'URL', with: 'google.com'

    click_on 'Publish'

    within '.answers' do
      expect(page).to have_content 'test answer'
    end
  end

  it 'User adds gist when asks question', js: true do
    gist_title = 'Test gist'
    fill_in 'Link name', with: gist_title
    fill_in 'URL', with: gist_url

    click_on 'Publish'
    refresh
    within('.answers') do |answers|
      expect(answers).to have_content gist_github_title
      expect(answers).not_to have_content gist_title
    end
  end
end
