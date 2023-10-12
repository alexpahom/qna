require 'rails_helper'

describe 'User can sign out', "
  In order to finish session
  as an signed in user
  I'd like to be able to sign out
" do

  let(:user) { User.create!(email: 'example@test.com', password: 'qwerty') }

  before do
    visit new_user_session_path
  end

  it 'Session can be finished successfully' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    click_on 'Logout'

    visit new_question_path

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
