class Answer < ApplicationRecord
  before_update :validate_best

  belongs_to :question
  belongs_to :author, class_name: 'User'

  has_many_attached :files

  validates :body, presence: true

  def validate_best
    return unless best?

    question.answers.where.not(id: id).update_all(best: false)
  end
end
