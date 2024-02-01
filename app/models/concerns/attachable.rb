# frozen_string_literal: true

module Attachable
  extend ActiveSupport::Concern

  included do
    has_many :links, dependent: :destroy, as: :linkable
    has_many_attached :files

    accepts_nested_attributes_for :links, reject_if: :all_blank
  end
end
