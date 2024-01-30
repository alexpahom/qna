# frozen_string_literal: true

class UrlValidator < ActiveModel::EachValidator
  URL_REGEX = /((http|https):\/\/.)[-a-zA-Z0-9@:%._\\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\\+.~#?&\/=]*)/
  def validate_each(record, attribute, value)
    return if value.blank?

    record.errors.add(attribute, :invalid) unless value.match? URL_REGEX
  end
end
