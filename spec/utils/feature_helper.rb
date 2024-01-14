# frozen_string_literal: true

module FeatureHelper
  def login(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    sign_in(user)
  end
end
