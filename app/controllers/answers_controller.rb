class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :set_question, only: %i[show new edit create]
  before_action :set_answer, only: %i[show edit update destroy]

  def show; end

  def new
    @answer = Answer.new
  end

  def create
    @answer = @question.answers.build(**answer_params, author: current_user)

    if @answer.save
      redirect_to @question
    else
      render 'questions/show'
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to answer_path(@answer)
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to @answer.question
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
