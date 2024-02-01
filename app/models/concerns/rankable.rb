# frozen_string_literal: true

module Rankable
  extend ActiveSupport::Concern

  included do
    has_many :ranks, dependent: :destroy, as: :rankable

    before_save :prevent_tampering
  end

  def ranking
    ranks.sum(:value)
  end

  def clear_user_ranks
    ranks.where(author: current_user).destroy_all
  end

  def process_rank(value, author)
    existing_rank = ranks.where(author: author).first

    if existing_rank
      if existing_rank.value == value.to_i
        existing_rank.destroy
      else
        existing_rank.update(value: value)
      end
    else
      ranks.create(author: author, value: value)
    end
  end

  private

  def prevent_tampering
    puts 'HERE--------------------------------------------------------------------------'
  end
end
