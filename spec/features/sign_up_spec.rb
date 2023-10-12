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

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
