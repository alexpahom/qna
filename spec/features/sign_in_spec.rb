require 'rails_helper'

describe 'User can sign in', "
  In order to ask question
  as an unathorized user
  I'd like to be able to sign in
" do

  let(:user) { User.create!(email: 'example@test.com', password: 'qwerty') }

  before do
    visit new_user_session_path
  end

  it 'Registered user tries to sign in' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content('Signed in successfully')
  end

  it 'Unregistered user tries to sign in' do
    fill_in 'Email', with: 'wrong@gmail.com'
    fill_in 'Password', with: 'asdfgh'
    click_on 'Log in'

    expect(page).to have_content('Invalid Email or password.')
  end
end
