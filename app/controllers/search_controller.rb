class SearchController < ApplicationController

  skip_authorization_check

  def index
    @results  = Services::Search.perform(search_params)
  end

  private

  def search_params
    params.permit(:query, :scope)
  end
end
