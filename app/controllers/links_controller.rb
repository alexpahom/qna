class LinksController < ApplicationController
  def destroy
    @link = Link.find(params[:id])
    @link.destroy
  end
end
