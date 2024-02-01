# frozen_string_literal: true

module Rankable
  extend ActiveSupport::Concern

  included do
    has_many :ranks, dependent: :destroy, as: :rankable
  end

  def ranking
    ranks.sum(:value)
  end

  def rank_given(user)
    ranks.where(author: user).first
  end

  def process_rank(value, author)
    existing_rank = ranks.where(author: author).first
    if existing_rank
      value = prevent_tampering(value)
      if existing_rank.value == value
        existing_rank.destroy
      else
        existing_rank.update(value: value)
      end
    else
      ranks.create(author: author, value: value)
    end
  end

  private

  def prevent_tampering(value)
    value.to_i > 0 ? 1 : -1
  end
end
