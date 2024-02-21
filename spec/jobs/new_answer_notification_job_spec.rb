require 'rails_helper'

RSpec.describe NewAnswerNotificationJob, type: :job do
  let(:service) { double('AnswerNotificationService') }

  before do
    allow(Services::NewAnswerNotificationsService).to receive(:new).and_return(service)
  end

  it 'calls DailyDigestService and returns service' do
    expect(service).to receive(:notify)
    NewAnswerNotificationJob.perform_now(create(:question))
  end
end
