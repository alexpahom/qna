class Answer < ApplicationRecord
  before_update :assign_best

  belongs_to :question
  belongs_to :author, class_name: 'User'

  has_many :links, dependent: :destroy, as: :linkable
  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :body, presence: true

  def assign_best
    return unless best?

    ActiveRecord::Base.transaction do
      question.answers.where.not(id: id).update_all(best: false)

      return unless question.badge.present?
      UsersBadge.where(badge: question.badge).destroy_all
      self.author.badges << question.badge
    end
  end
end
