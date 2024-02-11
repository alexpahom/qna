class EmailController < ApplicationController
  skip_authorization_check

  def new
    if session[:auth]
      @user = User.new
    else
      redirect_to new_user_session_path, alert: 'Error'
    end
  end

  def create
    password = Devise.friendly_token[0, 20]
    @user = User.create(email: params[:email], password: password, password_confirmation: password)
    auth = OmniAuth::AuthHash.new(
      provider: session['auth']['provider'], uid: session['auth']['uid'], info: { email: @user.email }
    )

    @user.create_authorization(auth) if @user.valid?

    if @user.persisted?
      @user.send_confirmation_instructions
    else
      render :new
    end
  end

  private

  def email_params
    params.require(:email).permit([:email])
  end
end
