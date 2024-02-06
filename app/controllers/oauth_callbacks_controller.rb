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
    @user = Services::FindForOauth.new(request.env['omniauth.auth']).call
    if @user&.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
    else
      redirect_to root_path, alert: 'Something went wrong'
    end
  end
end
