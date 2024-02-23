# frozen_string_literal: true

class Services::Search
  SCOPES = %w[thinking_sphinx user comment question answer].freeze

  def self.perform(query)
    return unless SCOPES.include?(query[:scope])

    query[:scope].classify.constantize.search(query)
  end
end
