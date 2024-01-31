require 'rails_helper'

feature 'User can add links to question', %{
  In order to provide additional info to question
  As question's author
  I'd like to be able to add links
} do

  let(:user) { create(:user) }
  let(:gist_url) { 'https://gist.github.com/alexpahom/651f8504557765a1c2fb58bd75b9210b' }

  it 'User add links when asks questions' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'test description'

    fill_in 'Link', with: 'My gist'
    fill_in 'URL', with: gist_url

    click_on 'Publish'

    expect(page).to have_link 'My gist', href: gist_url
  end
end
