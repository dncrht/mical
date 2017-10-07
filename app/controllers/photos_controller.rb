class PhotosController < ApplicationController

  before_action :only_logged_and_capable

  def create
    event = Event.find(params[:event_id])
    photo = event.photos.build(photo_params)
    photo.save
    render json: PhotoAttributes.new(photo).call(photo_path(photo))
  end

  def destroy
    photo = Photo.find_by(id: params[:id])
    photo.destroy
    head :ok
  end

  private

  def only_logged_and_capable
    redirect_to root_path if !signed_in? || !current_user.can_edit_event
  end

  def photo_params
    params.require(:photo).permit!
  end
end
