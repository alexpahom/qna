# frozen_string_literal: true

class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :find_question, only: %i[show update destroy]

    def index
      @questions = Question.all
      render json: @questions
    end

    def show
      render json: @question
    end

    def create
      @question = current_resource_owner.questions.new(question_params)

      if @question.save
        render json: @question, status: :created
      else
        render json: { errors: @question.errors }, status: :unprocessable_entity
      end
    end

  def update
    authorize! :update, @question
    if @question.update(question_params)
      render json: @question, status: :created
    else
      render json: { errors: @question.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :update, @question
    @question.destroy
    render json: { messages: ["Question was successfully deleted."] }
  end

    private

    def question_params
      params.require(:question).permit(:title, :body)
    end

    def find_question
      @question = Question.find(params[:id])
    end
end
