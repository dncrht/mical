class AdminController < ApplicationController
  before_filter :guest_restricted

  def guest_restricted
    if @logged_as.email == 'guest'
      render '/login', :layout => nil, :status => 403
      return
    end

    #go on
    @actividades = Actividad.all
  end
end