class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validates :url, url: true

  before_validation :append_scheme

  private

  def append_scheme
    url.prepend('https://') unless url.match? /^(http|https):\/\//
  end
end
