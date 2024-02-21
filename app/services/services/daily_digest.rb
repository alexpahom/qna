# frozen_string_literal: true

class Services::DailyDigest
  def send_digest
    titles = todays_question_titles
    User.find_each(batch_size: 500) do |user|
      DailyDigestMailer.digest(user, titles).deliver_later
    end
  end

  private

  def todays_questions
    Question.where('created_at > ?', DateTime.now.beginning_of_day)
  end

  def todays_question_titles
    todays_questions.map(&:title).join("\n")
  end
end
