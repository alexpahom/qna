require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:authorizations).dependent(:destroy) }
  let!(:user) { create(:user) }

  describe '.find_for_oauth' do

    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }
    let(:service) { double('Services::FindForOauth') }

    it 'calls Services::FindForOauth' do
      expect(Services::FindForOauth).to receive(:new).with(auth).and_return(service)
      expect(service).to receive(:call)
      User.find_for_oauth(auth)
    end
  end

  describe '#subscribed_on?' do
    let(:user_not_sub) { create(:user) }
    let(:question) { create(:question, author: user) }
    let(:subscription) { create(:subscription, question: question, author: user) }

    it 'return true if user subscribed' do
      expect(user).to be_subscribed_on(question)
    end

    it 'return false if unsubscribed' do
      expect(user_not_sub).to_not be_subscribed_on(question)
    end
  end
end
