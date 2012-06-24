class HomeController < ApplicationController

  # GET /:year
  def index
    today = Date.today
    @today = today
    @year = today.year

    if params[:year].to_i == @year #redirect to / if @year is current year
      redirect_to root_path
      return
    end

    @nombres_mes = ['', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
    @years = (1996..@year).to_a

    if params[:year].to_i >= 1996 #mejorar validación
      @year = params[:year].to_i
    end

    events = Event.where('day >= ? AND day <= ?', "#@year-01-01", "#@year-12-31").order('day')
    @events = Hash[*events.collect { |e| [e.day.to_s, e]}.flatten] #http://snippets.dzone.com/posts/show/302
  end

  # GET /
  # GET /?year=
  # Transforms requests with parameter to make a friendlier URL
  # Also, it renders / requests, so we avoid redirecting to index
  def index_query_string
    if params[:year].to_i >= 1996
      redirect_to root_path << params[:year]
    else
      index
      render 'index'
    end
  end

  # PUT /action
  def replace
    redirect_to root_path and return unless @logged_as.can_edit_event

    unless params[:day].blank?
      e = Event.find_by_day(params[:day])
      if e.nil?
        e = Event.new #TODO .create doesn't work?
        e.day = params[:day]
      end
      e.activity_id = params[:activity_id] #there is only one activity per day
      e.description = params[:description]
      e.save

      if params[:year].to_i >= 1996
        redirect_to root_path << params[:year]
        return
      end
    end

    redirect_to root_path
  end

  # DELETE /action
  def destroy
    redirect_to root_path and return unless @logged_as.can_edit_event

    unless params[:day].blank?
      e = Event.find_by_day(params[:day])
      e.delete
    end

    if params[:year].to_i >= 1996
      redirect_to root_path << params[:year]
      return
    end

    redirect_to root_path
  end

  def export
    out = ''

    Event.order('day').each do |e|
      out << "#{e.day}\t#{e.activity_id}\t#{e.description}\n"
    end

    render :text => out #TODO csv attachment
  end
end
