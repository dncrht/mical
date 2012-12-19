class Admin::ActivitiesController < AdminController
  before_filter :set_tab, :restricted

  def index
    @activities = Activity.order('name')
  end
  
  def show
    redirect_to edit_admin_activity_path(params[:id])
  end
  
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
    render(:text => 'Forbidden', :layout => true, :status => 403) and return unless current_user.can_edit_activity
  end
  
  def set_tab
    @tab = :activities
  end
end