require 'rails_helper'

feature 'User can add links to answer', %{
  In order to provide additional info to answer
  As question's author
  I'd like to be able to add links
} do

  let(:user) { create(:user) }
  let!(:question) { create(:question) }
  let(:gist_url) { 'https://gist.github.com/alexpahom/651f8504557765a1c2fb58bd75b9210b' }
  let(:gist_github_title) { 'gist_sample' }

  it 'User add links when leaves answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Answer', with: 'test answer'

    fill_in 'Link', with: 'My gist'
    fill_in 'URL', with: gist_url

    click_on 'Publish'

    within '.answers' do
      expect(page).to have_link 'My gist', href: gist_url
    end
  end

  it 'User adds gist when asks question', js: true do
    gist_title = 'Test gist'
    fill_in 'Link', with: gist_title
    fill_in 'URL', with: gist_url

    click_on 'Publish'

    within('.answers') do |answers|
      expect(answers).to have_content gist_github_title
      expect(answers).not_to have_content gist_title
    end
  end
end
