# frozen_string_literal: true

class Services::Search
  SCOPES = %w[thinking_sphinx user comment question answer].freeze

  def self.perform(input)
    return unless SCOPES.include?(input[:scope])

    escaped = ThinkingSphinx::Query.escape(input[:query])
    input[:scope].classify.constantize.search(escaped)
  end
end
