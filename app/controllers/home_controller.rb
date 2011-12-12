class HomeController < ApplicationController

  # GET /:anyo
  def index
    hoy = Date.today
    @año = hoy.year

    if params[:anyo].to_i == @año #redirigir a / si el año es el actual
      redirect_to root_path
      return
    end

    @nombres_mes = ['', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
    @hoy = "#{hoy.day} de #{@nombres_mes[hoy.month]}"
    @años = (1996..@año).to_a

    if params[:anyo].to_i >= 1996 #mejorar validación
      @año = params[:anyo].to_i
    end

    efemerides = Efemeride.where('dia >= ? AND dia <= ?', "#@año-01-01", "#@año-12-31").order('dia')
    @efemerides = Hash[*efemerides.collect { |e| [e.dia.to_s, e]}.flatten] #http://snippets.dzone.com/posts/show/302
  end

  # GET /
  # GET /?anyo=
  # Transforma las peticiones con parámetro para embellecer la URL
  # Renderiza las peticiones / , así evitamos hacer redirección a index
  def index_query_string
    if params[:anyo].to_i >= 1996
      redirect_to root_path << params[:anyo]
    else
      index
      render 'index'
    end
  end

  # PUT /action
  def replace
    redirect_to root_path and return unless @logged_as.can_edit_efemeride

    unless params[:day].blank?
      e = Efemeride.find_by_dia(params[:day])
      if e.nil?
        e = Efemeride.new #TODO .create doesn't work?
        e.dia = params[:day]
      end
      e.actividad_id = params[:activity_id] #there is only one activity per day
      e.resumen = params[:resumen]
      e.save

      if params[:anyo].to_i >= 1996
        redirect_to root_path << params[:anyo]
        return
      end
    end

    redirect_to root_path
  end

  # DELETE /action
  def destroy
    redirect_to root_path and return unless @logged_as.can_edit_efemeride

    unless params[:day].blank?
      e = Efemeride.find_by_dia(params[:day])
      e.delete
    end

    if params[:anyo].to_i >= 1996
      redirect_to root_path << params[:anyo]
      return
    end

    redirect_to root_path
  end

  def export
    out = ''

    Efemeride.order('dia').each do |e|
      out << "#{e.dia}\t#{e.actividad_id}\t#{e.resumen}\n"
    end

    render :text => out #TODO csv attachment
  end
end
