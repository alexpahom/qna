class Link < ApplicationRecord
  GIST_REGEXP = /^https:\/\/gist.github.com\/[a-zA-Z0-9]*\/[a-zA-Z0-9]*$/.freeze
  GIST_ID_REGEXP = /^*.*\/([a-zA-Z0-9]*)$/.freeze

  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validates :url, url: true

  before_validation :append_scheme

  def gist?
    url.match? GIST_REGEXP
  end

  def gist_id
    return unless gist?
    url.match(GIST_ID_REGEXP)[-1]
  end

  private

  def append_scheme
    return unless url
    url.prepend('https://') unless url.match?(/^(http|https):\/\//)
  end
end
