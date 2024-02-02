require 'rails_helper'

describe 'user can delete their answers', "
  In order delete my own answer
  As an authenticated user
  I'd like to be able to delete my answer
" do

  let(:user) { create(:user) }
  let(:question) { create(:question, :answered) }
  let(:answer_text) { 'Lorem Ipsum' }

  before do
    login(user)
    visit question_path(question)
  end

  describe 'Delete answer' do
    it 'deletes user\'s own answer', js: true do
      fill_in 'Answer', with: answer_text
      click_on 'Publish'
      refresh # TODO: requires js-template builder

      within('.answers') { click_on 'Delete' }
      expect(page).not_to have_content answer_text
    end

    it 'can delete attachment', js: true do
      fill_in 'Answer', with: answer_text
      attach_file 'Attach', ["#{Rails.root.join('spec/rails_helper.rb')}", "#{Rails.root.join('spec/spec_helper.rb')}"]
      click_on 'Publish'

      refresh # TODO: requires js-template builder
      find_link(id: 'delete_attachment_rails_helper.rb').click
      find_link(id: 'delete_attachment_spec_helper.rb').click
      expect(page).not_to have_content 'rails_helper.rb'
      expect(page).not_to have_content 'spec_helper.rb'
    end
  end

  describe 'Unsuccessful delete' do
    it 'cannot delete another user\'s question' do
      within('.answers') do
        expect(page).not_to have_content 'Delete'
      end
    end
  end
end
