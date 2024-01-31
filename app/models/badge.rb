class Badge < ApplicationRecord
  has_one :users_badge, dependent: :destroy
  belongs_to :question

  has_one_attached :image
  validates :description, presence: true
end
