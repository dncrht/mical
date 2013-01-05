class HomeController < ApplicationController

  # GET /(:year)
  def index
    @today = Date.today

    # Redirects to / when requesting /current_year, to clean the URL
    if request.path == "/#{@today.year}" and request.format == :html
      redirect_to root_path
      return
    end

    # Prepares the years list
    first_year = Event.first.nil? ? @today.year : Event.first.day.year
    @years = (first_year..@today.year).to_a

    # Determines the requested year
    @year = params[:year].blank? ? @today.year : params[:year].to_i

    # Prepares the event list of the requested year
    events = Event.where('day >= ? AND day <= ?', "#@year-01-01", "#@year-12-31").order('day')
    @events = Hash[*events.collect { |e| [e.day.to_s, e]}.flatten] #http://snippets.dzone.com/posts/show/302
    
    # Prepares the activities list
    @activities = Activity.order('name')
    
    respond_to do |format|
      if signed_in? and current_user.can_download
        format.csv {
          headers['Content-Type'] = 'text/csv'
          headers['Content-Disposition'] = %(attachment; filename="events_#@year.csv")        
        }
      end
      format.html
    end
  end

  # PUT /action
  def replace
    redirect_to root_path and return if !signed_in? or !current_user.can_edit_event

    e = Event.replace(params[:day], params[:activity_id], params[:description])

    redirect_to root_path << e.day.year.to_s
  end

  # DELETE /action
  def destroy
    redirect_to root_path and return if !signed_in? or !current_user.can_edit_event

    redirection = root_path

    if params[:day].present?
      e = Event.find_by_day(params[:day])
      e.destroy
      redirection << e.day.year.to_s
    end

    redirect_to redirection
  end

end
