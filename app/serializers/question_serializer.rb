class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :short_title, :body, :author_id, :created_at, :updated_at
  has_many :answers

  def short_title
    object.title.truncate 7
  end
end
