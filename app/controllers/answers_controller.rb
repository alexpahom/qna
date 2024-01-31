class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :set_question, only: %i[show new create]
  before_action :set_answer, only: %i[show edit update destroy]

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
end
