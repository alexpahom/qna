require 'rails_helper'

RSpec.describe EmailController, type: :controller do
  let(:user) { create(:user) }

  before { get :new }

  describe "GET #new" do
    it 'renders new' do
      expect(response).to render_template :new
    end
  end

  describe "GET #create" do
    context 'with valid attributes' do
      it 'saves user in db' do
        expect { post :create, params: { email: user.email } }.to change(User, :count).by(1)
      end

      it 'renders #new' do
        expect(response).to render_template :new
      end
    end

    context 'with invalid attributes' do
      it 'does not save user' do
        expect { post :create, params: { email: '' } }.to_not change(User, :count)
      end

      it 'renders #new' do
        post :create, params: { email: '' }
        expect(response).to render_template :new
      end
    end
  end

end
