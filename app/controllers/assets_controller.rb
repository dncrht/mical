class AssetsController < ApplicationController

  before_action :only_logged_and_capable

  def create
    event = Event.find(params[:event_id])
    asset = event.assets.build(asset_params)
    asset.save
    render json: {
      id: asset.id,
      attributes: AssetAttributes.new(asset).call(asset_path(asset))
    }
  end

  def destroy
    asset = Asset.find_by(id: params[:id])
    asset.destroy
    render json: {id: params[:id]}
  end

  private

  def only_logged_and_capable
    redirect_to root_path if !signed_in? || !current_user.can_edit_event
  end

  def asset_params
    params.require(:asset).permit!
  end
end
