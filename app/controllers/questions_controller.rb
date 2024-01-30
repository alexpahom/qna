class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :get_question, only: %i[show edit update destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @answer.links.new
  end

  def new
    @question = Question.new
    @question.links.new
    @question.badge = Badge.new
  end

  def edit; end

  def create
    @question = Question.new(**question_params, author: current_user)
    if @question.save
      redirect_to @question, success: 'Your question successfully created'
    else
      render :new
    end
  end

  def update
    @question.update(question_params)
  end

  def destroy
    @question.destroy
  end

  private

  def get_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [],
                                     links_attributes: [:name, :url, :id, :_destroy],
                                     badge_attributes: [:description, :image])
  end
end
