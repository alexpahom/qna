class NewAnswerNotificationJob < ApplicationJob
  queue_as :default

  def perform(question)
    Services::NewAnswerNotificationsService.new.notify(question)
  end
end
