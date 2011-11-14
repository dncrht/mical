class HomeController < ApplicationController
  def index
    @año = Date.today.year
    @años = (1996..@año).to_a

    if params[:anyo].to_i >= 1996
      @año = params[:anyo].to_i
    end

    @efemerides = Efemeride.order('dia')
  end

  def export
    out = ''

    Efemeride.order('dia').each do |e|
      out << "#{e.dia}\t#{e.actividad}\t#{e.resumen}\n"
    end

    render :text => out #TODO csv attachment
  end
end
