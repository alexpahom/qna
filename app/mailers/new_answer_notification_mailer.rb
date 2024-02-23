class NewAnswerNotificationMailer < ApplicationMailer
  def notify(user, question)
    @user = user
    @question = question
    mail to: user.email
  end
end
