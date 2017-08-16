module Api
  class PhotosController < BaseController

    def create
      event = Event.find_by(id: params[:event_id])
      render status: :not_found and return unless event

      photo = event.photos.build(image: params[:image])
      photo.save

      render json: {id: photo.id}
    end
  end
end
