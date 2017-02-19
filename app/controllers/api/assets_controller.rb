module Api
  class AssetsController < BaseController

    def create
      event = Event.find_by(id: params[:event_id])
      render status: :not_found and return unless event

      asset = event.assets.build(image: params[:image])
      asset.save

      render json: {id: asset.id}
    end
  end
end
