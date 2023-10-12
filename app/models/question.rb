class Question < ApplicationRecord
  has_many :answers, dependent: :nullify
  belongs_to :author, class_name: 'User'

  validates :title, :body, presence: true
end
