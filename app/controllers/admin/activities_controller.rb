class Admin::ActivitiesController < AdminController
  before_filter :restricted

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(params[:activity])

    if @activity.save
      redirect_to admin_activities_path, :notice => 'Activity created'
    else
      render 'new'
    end
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])

    if @activity.update_attributes(params[:activity])
      redirect_to admin_activities_path, :notice => 'Activity updated'
    else
      render 'edit'
    end
  end

  def destroy
    @activity = Activity.find(params[:id])

    @activity.delete
    redirect_to admin_activities_path, :notice => 'Activity deleted'
  end

  private
  
  def restricted
    render :status => 403 unless @logged_as.can_edit_activity

    @tab = :activities
  end
end