require 'rails_helper'

describe 'user can create question', "
  In order to find a solution for my issue
  As an authenticated user
  I'd like to be able to publish the question
" do

  let(:user) { create(:user) }

  describe 'Authenticated user' do
    before do
      login(user)
      visit questions_path
      click_on 'New Question'
    end

    it 'asks question' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'Lorem ipsum dolor'
      click_on 'Publish'

      expect(page).to have_content 'Your question successfully created'
    end

    it 'asks question with errors' do
      click_on 'Publish'

      expect(page).to have_content "Title can't be blank"
    end

    it 'asks a question with attachment' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'Lorem ipsum dolor'
      attach_file 'Attach', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Publish'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  it 'Unauthenticated user tries to ask a question' do
    visit questions_path

    expect(page).not_to have_content 'Ask question'
  end
end
