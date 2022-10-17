class PhotosController < ApplicationController
  before_action :only_logged_and_capable

  def create
    @event = Event.find(params[:event_id])

    Array(params[:photo][:image]).map do |image|
      @event.photos.create image: image
    end

    render 'index'
  end

  def destroy
    photo = Photo.find_by(id: params[:id])
    photo.destroy

    @event = Event.find(photo.event_id)
    render 'index'
  end

  private

  def only_logged_and_capable
    head :forbidden if !current_user&.can_edit_event
  end
end
