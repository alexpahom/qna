require 'rails_helper'

describe 'User can sign up', "
  In order to log in
  as an unregistered user
  I'd like to be able to sign up
" do

  let(:register_data) { build(:user) }

  it 'Session can be finished successfully' do
    visit new_user_registration_path
    fill_in 'Email', with: register_data.email
    fill_in 'Password', with: register_data.password
    fill_in 'Password confirmation', with: register_data.password
    click_on 'Sign up'

    expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'

    open_email(register_data.email)
    current_email.click_link 'Confirm my account'
    expect(page).to have_content 'Your email address has been successfully confirmed.'
  end
end
