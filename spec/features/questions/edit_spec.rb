require 'rails_helper'

describe 'user can edit his own question', "
  In order to edit question
  As an authenticated user
  I'd like to be able to edit my own question
" do
  let(:question) { create(:question, :with_attachments) }

  describe 'Authenticated user' do
    before do
      login(question.author)
      visit questions_path
      click_on 'Edit'
    end

    it 'can attach file during update', js: true do
      fill_in 'Title', with: 'question title'
      fill_in 'Body', with: 'test description'
      attach_file 'Attach', ["#{Rails.root.join('spec/rails_helper.rb')}", "#{Rails.root.join('spec/spec_helper.rb')}"]

      click_on 'Update'
      visit question_path(question.id)
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    it 'edits question', js: true do
      new_title = 'Updated title'
      new_body = 'Updated body'

      fill_in 'Title', with: new_title
      fill_in 'Body', with: new_body
      click_on 'Update'

      within("#question_#{question.id}") do |node|
        expect(node).to have_content new_title
        expect(node).to have_content new_body
      end
    end

    it 'edits question with invalid params', js: true do
      fill_in 'Title', with: ''
      fill_in 'Body', with: ''
      click_on 'Update'

      expect(page).to have_content "Title can't be blank"
    end
  end

  it 'Unauthenticated user tries to edit a question' do
    visit questions_path

    expect(page).not_to have_content 'Edit'
  end
end