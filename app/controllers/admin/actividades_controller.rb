class Admin::ActividadesController < AdminController
  before_filter :restricted

  def new
    @actividad = Actividad.new
  end

  def create
    @actividad = Actividad.new(params[:actividad])

    if @actividad.save
      redirect_to admin_actividades_path, :notice => 'Activity created'
    else
      render 'new'
    end
  end

  def edit
    @actividad = Actividad.find(params[:id])
  end

  def update
    @actividad = Actividad.find(params[:id])

    if @actividad.update_attributes(params[:actividad])
      redirect_to admin_actividades_path, :notice => 'Activity created'
    else
      render 'edit'
    end
  end

  def destroy
    @actividad = Actividad.find(params[:id])

    @actividad.delete
    redirect_to admin_actividades_path, :notice => 'Activity deleted'
  end

  private
  def restricted
    render :status => 403 unless @logged_as.can_edit_actividad

    @tab = :activities
  end
end