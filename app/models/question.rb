class Question < ApplicationRecord
  include Rankable
  include Attachable
  include Commentable

  has_many :answers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  belongs_to :author, class_name: 'User'
  has_one :badge, dependent: :destroy

  accepts_nested_attributes_for :badge, reject_if: :all_blank

  validates :title, :body, presence: true

  after_create :calculate_reputation, :auto_subscribe!

  private

  def calculate_reputation
    ReputationJob.perform_later(self)
  end

  def auto_subscribe!
    subscriptions.create!(user: author)
  end
end
