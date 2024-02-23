class SearchController < ApplicationController

  skip_authorization_check

  def index
    if params[:query].blank?
      render :index
    else
      @results  = Services::Search.perform(search_params)
    end
  end

  private

  def search_params
    params.permit(:query, :scope)
  end
end
