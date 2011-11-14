class HomeController < ApplicationController
  def index
    hoy = Date.today
    @nombres_mes = ['', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
    @hoy = "#{hoy.day} de #{@nombres_mes[hoy.month]}"

    @año = hoy.year
    @años = (1996..@año).to_a

    if params[:anyo].to_i >= 1996
      @año = params[:anyo].to_i
    end

    efemerides = Efemeride.where('dia >= ? AND dia <= ?', "#@año-01-01", "#@año-12-31").order('dia')
    @efemerides = Hash[*efemerides.collect { |e| [e.dia.to_s, e]}.flatten] #http://snippets.dzone.com/posts/show/302
  end
  
  def replace
    unless params[:hoy].blank?
      dia, actividad_id, resumen = params[:hoy].split "\t"
      e = Efemeride.new #TODO ¿no funciona .create?
      e.dia = dia
      e.actividad_id = actividad_id
      e.resumen = resumen
      e.save

      if params[:anyo].to_i >= 1996
        redirect_to root_path << "?anyo=" << params[:anyo]
        return
      end
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
