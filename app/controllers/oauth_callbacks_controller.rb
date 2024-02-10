# frozen_string_literal: true

class OauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    oauth('GitHub')
  end

  def google_oauth2
    oauth('Google')
  end

  private

  def oauth(provider)
    auth_params = request.env['omniauth.auth']
    return if handle_no_email(auth_params)

    @user = User.find_for_oauth(auth_params)
    if @user&.confirmed?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
    elsif @user && !@user.confirmed?
      redirect_to new_user_session_path, alert: 'Check your inbox to verify email first'
    else
      redirect_to root_path, alert: 'Something went wrong'
    end
  end

  def handle_no_email(auth_params)
    return unless auth_params
    auth = { provider: auth_params['provider'], uid: auth_params['uid'] }

    if !auth_params.info[:email] && Authorization.where(auth).empty?
      session[:auth] = auth
      redirect_to email_new_path
      true
    end
  end
end
