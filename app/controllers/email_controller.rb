class EmailController < ApplicationController
  def new
    @user = User.new
  end

  def create
    password = Devise.friendly_token[0, 20]
    @user = User.create(email: params[:email], password: password, password_confirmation: password)
    auth = OmniAuth::AuthHash.new(provider: params[:provider], uid: params[:uid], info: { email: @user.email })

    @user.create_authorization(auth) if @user.valid?

    if @user.persisted?
      @user.send_confirmation_instructions
    else
      render :new
    end
  end

  private

  def email_params
    params.require(:email).permit([:email, :uid, :provider])
  end
end
