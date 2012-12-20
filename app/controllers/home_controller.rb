class HomeController < ApplicationController

  # GET /:year
  def index
    @activities = Activity.order('name')
    
    today = Date.today
    @today = today
    @year = today.year

    if params[:year].to_i == @year #redirect to / if @year is current year
      redirect_to root_path
      return
    end

    @years = (1996..@year).to_a

    if params[:year].to_i >= 1996 #mejorar validación
      @year = params[:year].to_i
    end

    events = Event.where('day >= ? AND day <= ?', "#@year-01-01", "#@year-12-31").order('day')
    @events = Hash[*events.collect { |e| [e.day.to_s, e]}.flatten] #http://snippets.dzone.com/posts/show/302
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

    unless params[:day].blank?
      e = Event.find_by_day(params[:day])
      e.destroy
    end

    redirect_to root_path << e.day.year.to_s
  end

  def export
    out = ''

    Event.order('day').each do |e|
      out << "#{e.day}\t#{e.activity_id}\t#{e.description}\n"
    end

    render :text => out #TODO csv attachment
  end
end
