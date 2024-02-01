class RanksController < ApplicationController
  before_action :authenticate_user!

  def create
    resource = Question.find(params[:resource_id])
    return if resource.author == current_user
    resource.process_rank(params[:value], current_user)
  end

  private

  def resource
    params[:class].constantize
  end
end
