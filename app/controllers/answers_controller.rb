class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :set_question, only: %i[show new create]
  before_action :set_answer, only: %i[show edit update destroy assign_best]

  after_action :publish_answer, only: :create

  authorize_resource

  def create
    @answer = @question.answers.build(**answer_params, author: current_user)

    respond_to do |format|
      if @answer.save
        format.json { render json: @answer }
      else
        format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    @answer.update(answer_params)
    respond_to do |format|
      format.html { redirect_to question_path(@answer.question) }
      format.js
    end
  end

  def destroy
    @answer.destroy
  end

  def assign_best
    @answer.update(best: true)
    respond_to do |format|
      format.html { redirect_to question_path(@answer.question) }
      format.js { render :update }
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :best, files: [], links_attributes: [:name, :url, :id, :_destroy])
  end

  def publish_answer
    params =
      if @answer.errors.empty?
        {
          status: :ok,
          render_params: { partial: 'answers/answer_simplified', locals: { answer: @answer } }
        }
      else
        {
          status: :unprocessable_entity,
          render_params: { partial: 'shared/errors', locals: { resource: @answer } }
        }
      end

    ActionCable.server.broadcast(
      "question_#{@question.id}",
      { status: params[:status], body: ApplicationController.render(params[:render_params]) }
    )
  end
end
