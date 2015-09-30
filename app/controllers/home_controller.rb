require 'csv'

class HomeController < ApplicationController

  before_filter :clean_current_year_url, :set_year, only: :index

  # GET /(:year)
  def index
    # Prepares the years list
    @years = Event.first_year..@today.year

    # Prepares the event list of the requested year
    @events = Event.to_h(Event.in_year(@year))

    # Prepares the activities list
    @activities = Activity.order('position')

    respond_to do |format|
      if signed_in? && current_user.can_download
        format.csv do
          headers['Content-Disposition'] = %(attachment; filename="events_#@year.csv")
          render text: csv_file
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
    @today ||= Date.current
  end

  # Determines the requested year
  def set_year
    @year = params[:year].blank? ? @today.year : params[:year].to_i
  end

  def csv_file
    CSV.generate(force_quotes: true) do |csv|
      @events.each do |day, event|
        csv << [day, event.activity.name, event.description.strip]
      end
    end
  end
end
