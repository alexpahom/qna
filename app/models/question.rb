class Question < ApplicationRecord
  include Rankable
  include Attachable
  include Commentable

  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User'
  has_one :badge, dependent: :destroy

  accepts_nested_attributes_for :badge, reject_if: :all_blank

  validates :title, :body, presence: true
end
