class EventsController < ApplicationController

    before_filter :only_logged_and_capable

    def show
      @activities = Activity.order('position')

      @event = Event.find_by(day: params[:id]) || Event.new(day: params[:id])

      @assets = @event.assets.reduce({}) do |hash, asset|
        hash[asset.id] = AssetAttributes.new(asset).call(asset_path(asset))
        hash
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
      redirection = if event
                      event.destroy
                      year_path(event.day.year)
                    else
                      root_path
                    end

      redirect_to redirection
    end

    private

    def only_logged_and_capable
      redirect_to root_path if !signed_in? || !current_user.can_edit_event
    end

    def event_params
      params.require(:event).permit!
    end
  end
