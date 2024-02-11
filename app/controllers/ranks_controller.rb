class RanksController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize! :process_rank, resource
    resource.process_rank(params[:value], current_user)

    respond_to do |format|
      format.json { render json: rank_info }
    end
  end

  private

  def resource
    @resource ||= params[:class].constantize.find(params[:resource_id])
  end

  def rank_info
    {
      ranking: resource.ranking,
      class: resource.class.name,
      resource_id: resource.id,
      rank_given: resource.rank_given(current_user)&.value
    }
  end

end
