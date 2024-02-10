require 'rails_helper'

describe 'Authorization over providers', %{
  In order to log into the app without explicit credentials
  As an unauthorized user
  I should be able to login using provider's info
} do

  before { visit new_user_session_path }
  let(:new_email) { 'no@email.com' }

  context 'GitHub' do

    it 'user signs in' do
      auth_hash(:github, 'email@example.com')
      click_on 'Sign in with GitHub'
      expect(page).to have_content 'Successfully authenticated from GitHub account'
    end

    it 'oauth provider doesn\'t return email' do
      auth_hash(:github, nil)
      click_on 'Sign in with GitHub'

      expect(page).to have_content 'Set up your account'
      fill_in 'email', with: new_email
      click_on 'Submit'

      open_email(new_email)
      current_email.click_link 'Confirm my account'
      expect(page).to have_content 'Your email address has been successfully confirmed.'
    end
  end

  context 'Google' do

    it 'user signs in' do
      auth_hash(:google_oauth2, 'email@example.com')
      click_on 'Sign in with GoogleOauth2'
      expect(page).to have_content 'Successfully authenticated from Google account'
    end

    it 'oauth provider doesn\'t return email' do
      auth_hash(:google_oauth2, nil)
      click_on 'Sign in with GoogleOauth2'

      expect(page).to have_content 'Set up your account'
      fill_in 'email', with: new_email
      click_on 'Submit'

      open_email(new_email)
      current_email.click_link 'Confirm my account'
      expect(page).to have_content 'Your email address has been successfully confirmed.'
    end
  end
end
