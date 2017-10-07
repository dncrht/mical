class EventsController < ApplicationController

  before_action :only_logged_and_capable
  skip_before_action :verify_authenticity_token, only: :destroy

  def show
    @activities = Activity.order('position')

    @event = Event.find_by(day: params[:id]) || Event.new(day: params[:id])

    @photos = @event.photos.map do |photo|
      PhotoAttributes.new(photo).call(photo_path(photo))
    end
  end

  def create
    event = Event.create(event_params)

    redirect_to year_path(event.day.year)
  end

  def update
    event = Event.find_by(id: params[:id])
    event.update_attributes event_params

    redirect_to year_path(event.day.year)
  end

  def destroy
    event = Event.find_by(id: params[:id])
    event.destroy
  end

  private

  def only_logged_and_capable
    redirect_to root_path if !signed_in? || !current_user.can_edit_event
  end

  def event_params
    params.require(:event).permit!
  end
end
