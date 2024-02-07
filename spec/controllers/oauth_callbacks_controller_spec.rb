require 'rails_helper'

RSpec.describe OauthCallbacksController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'Github' do

    let(:oauth_data) { OmniAuth::AuthHash.new(provider: 'google', uid: '123456', info: { email: 'test@email.com' }) }

    it 'find user from oauth data' do
      allow(request.env).to receive(:[]).and_call_original
      allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)

      expect(User).to receive(:find_for_oauth).with(oauth_data)
      get :github
    end

    context 'user exists' do
      let!(:user) { create(:user) }

      before do
        allow(User).to receive(:find_for_oauth).and_return(user)
        get :github
      end

      it 'login user' do
        expect(subject.current_user).to eq(user)
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'user not exist' do
      before do
        allow(User).to receive(:find_for_oauth)
        get :github
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end

      it 'does not login' do
        expect(subject.current_user).to_not be
      end
    end
  end

  describe 'Google' do
    let(:oauth_data) { OmniAuth::AuthHash.new(provider: 'google', uid: '123456', info: { email: 'test@email.com' }) }

    context 'user exists' do

      let(:user) { Services::FindForOauth.new(oauth_data).call }

      before do
        @request.env['omniauth.auth'] = auth_hash(:google, 'test@email.com')
        get :google_oauth2
      end

      it 'logs user in' do
        expect(subject.current_user).to eq(user)
      end

      it 'redirects to root' do
        expect(response).to redirect_to root_path
      end
    end

    context 'user does not exist' do

      before do
        allow(User).to receive(:find_for_oauth)
        get :google_oauth2
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'no email from provider' do
      let(:oauth_data) { OmniAuth::AuthHash.new(provider: 'google', uid: '123456', info: { email: 'nil' }) }

      before do
        @request.env['omniauth.auth'] = auth_hash(:google, nil)
        get :google_oauth2
      end

      it 'expect redirect to email setup page' do
        expect(response).to redirect_to email_new_path(provider: oauth_data.provider, uid: oauth_data.uid)
      end
    end
  end
end
