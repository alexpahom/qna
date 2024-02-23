# frozen_string_literal: true

class Services::NewAnswerNotificationsService
  def self.notify(question)
    question.subscriptions.find_each do |subscription|
      NewAnswerNotificationMailer.notify(subscription.user, question).deliver_now
    end
  end
end
