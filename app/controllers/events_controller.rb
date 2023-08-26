class EventsController < ApplicationController
  before_action :only_logged_and_capable
  before_action :find_activities, only: %i(show create update)

  def show
    @event = Event.find_by(day: params[:id]) || Event.new(day: params[:id])
  end

  def create
    @event = Event.create(event_params.to_h.slice!('activity_id'))
    create_event_activities if @event.id

    render 'show'
  end

  def update
    @event = Event.find_by(id: params[:id])
    @event.update(event_params.to_h.slice!('activity_id'))
    @event.event_activities.destroy_all
    create_event_activities

    render 'show'
  end

  def destroy
    event = Event.find_by(id: params[:id])
    event.destroy

    redirect_to "/#{event.day.year}", status: :see_other
  end

  private

  def only_logged_and_capable
    head :forbidden if !current_user&.can_edit_event
  end

  def find_activities
    @activities = Activity.order('position')
  end

  def event_params
    params.require(:event).permit!
  end

  def create_event_activities
    event_params['activity_id'].each do |id|
      next if id.blank?
      @event.event_activities.create activity_id: id
    end
  end
end
