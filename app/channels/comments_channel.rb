# frozen_string_literal: true

class CommentsChannel < ApplicationCable::Channel
  def follow(data)
    stream_from("comments_#{data['question_id']}")
  end
end
