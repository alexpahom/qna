class AttachmentsController < ApplicationController
  def purge
    @attachment = ActiveStorage::Attachment.find(params[:id])
    authorize! :destroy, @attachment
    @attachment.purge
  end
end
