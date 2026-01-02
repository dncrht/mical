require 'csv'

class HomeController < ApplicationController
  before_action :clean_current_year_url, :set_year, only: :index

  # GET /(:year)
  def index
    # Prepares the years list
    @years = if Event.exists?
               Event.order(day: :asc).first.day.year..Event.order(day: :desc).first.day.year
             else
               [Date.current.year]
             end

    # Prepares the event list of the requested year
    @events = Event.to_h(Event.in_year(@year))
    @event = Event.new

    # Prepares the activities list
    @activities = Activity.order('position')

    respond_to do |format|
      if current_user&.can_download
        format.csv do
          headers['Content-Disposition'] = %(attachment; filename="events_#@year.csv")
          self.response_body = Enumerator.new do |response|
            csv = CSV.new(response, col_sep: "\t")
            @events.each do |day, event|
              csv << [event.day, event.activity.name, event.description.strip]
            end
          end
        end
      end
      format.html
    end
  end

  private

  # In order to clean the URL, if the request is /current_year it redirects to /
  def clean_current_year_url
    if request.path == year_path(today.year) && request.format == :html
      redirect_to root_path
    end
  end

  def today
    @today = Date.current
  end

  # Determines the requested year
  def set_year
    @year = params[:year].blank? ? @today.year : params[:year].to_i
  end
end
