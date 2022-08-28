class EventsController < ApplicationController
  before_action :only_logged_and_capable
  #skip_before_action :verify_authenticity_token, only: :destroy

  def show
    @event = Event.find_by(day: params[:id]) || Event.new(day: params[:id])

    activities_and_photos
  end

  def create
    @event = Event.create(event_params)

    activities_and_photos

    render partial: 'save'
  end

  def update
    @event = Event.find_by(id: params[:id])
    @event.update event_params

    activities_and_photos

    render partial: 'save'
  end

  def destroy
    event = Event.find_by(id: params[:id])
    event.destroy
  end

  private

  def only_logged_and_capable
    redirect_to root_path if !signed_in? || !current_user.can_edit_event
  end

  def activities_and_photos
    @activities = Activity.order('position')
    @photos = @event.photos.map do |photo|
      PhotoAttributes.new(photo).call(photo_path(photo))
    end
  end

  def event_params
    params.require(:event).permit!
  end
end
