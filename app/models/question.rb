class Question < ApplicationRecord
  include Rankable

  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  belongs_to :author, class_name: 'User'
  has_one :badge, dependent: :destroy

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :badge, reject_if: :all_blank

  validates :title, :body, presence: true
end
