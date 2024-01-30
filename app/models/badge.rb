class Badge < ApplicationRecord
  has_one :users_badge, dependent: :destroy

  has_one_attached :image
  validates :description, presence: true
end
