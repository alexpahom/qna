class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :set_question, only: %i[show new create]
  before_action :set_answer, only: %i[show edit update destroy]

  def show; end

  def new
    @answer = Answer.new
  end

  def create
    @answer = @question.answers.build(**answer_params, author: current_user)
    @answer.save
  end

  def edit; end

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

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
