require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should have_many(:links).dependent(:destroy) }
  it { should belong_to :question }
  it { should accept_nested_attributes_for :links }

  describe 'new answers notifications' do
    let(:question) { create(:question) }

    it 'call notifications job' do
      expect(NewAnswerNotificationJob).to receive(:perform_later).with(question)
      question.answers.create(body: 'some text', author: create(:user))
    end
  end
end
