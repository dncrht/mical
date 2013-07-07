class Admin::ActivitiesController < AdminController
  before_filter :set_tab, :restricted

  def index
    @activities = Activity.order('position')
  end

  def show
    redirect_to edit_admin_activity_path(params[:id])
  end

  def new
    @activity = Activity.new(color: '#dddddd')
  end

  def create
    @activity = Activity.new(activity_params)

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

    if @activity.update_attributes(activity_params)
      redirect_to admin_activities_path, :notice => 'Activity updated'
    else
      render 'edit'
    end
  end

  def destroy
    @activity = Activity.find(params[:id])

    @activity.destroy
    redirect_to admin_activities_path, :notice => 'Activity deleted'
  end

  private

  def restricted
    render(:text => 'Forbidden', :layout => true, :status => 403) and return unless current_user.can_edit_activity
  end

  def set_tab
    @tab = :activities
  end

  def activity_params
    params.require(:activity).permit!
  end
end