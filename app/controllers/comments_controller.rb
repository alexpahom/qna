class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_resource, only: %i[new create]
  after_action :publish_comment, only: :create

  authorize_resource

  def new; end

  def create
    @comment = @resource.comments.build(body: params[:body], author: current_user)
    @comment.save ? head(:ok) : head(:unprocessable_entity)
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], author: current_user)
    @comment.destroy
  end

  private

  def find_resource
    @resource ||= params[:class].constantize.find(params[:resource_id])
  end
  def publish_comment
    params =
      if @comment.errors.empty?
        {
          status: :ok,
          render_params: { partial: 'comments/comment_simplified', locals: { comment: @comment } }
        }
      else
        {
          status: :unprocessable_entity,
          render_params: { partial: 'shared/errors', locals: { resource: @comment } }
        }
      end

    ActionCable.server.broadcast(
      "comments_#{question.id}",
      {
        status: params[:status],
        body: ApplicationController.render(params[:render_params]),
        resource_class: @comment.commentable.class.name.downcase,
        resource_id: @comment.commentable.id
      }
    )
  end

  def question
    @resource.instance_of?(Question) ? @resource : @resource.question
  end
end
