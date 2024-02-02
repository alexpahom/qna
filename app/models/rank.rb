class Rank < ApplicationRecord
  belongs_to :rankable, polymorphic: true
  belongs_to :author, class_name: 'User'

  validates :value, numericality: { only_integer: true }
end
