class Admin::EventsController < AdminController
  before_filter :set_tab, :restricted

  def index
    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = %(attachment; filename="events_all.csv")
        self.response_body = Enumerator.new do |response|
          csv = CSV.new(response, col_sep: "\t")
          Event.to_h(Event.all).each do |day, event|
            csv << [event.day, event.activity.name, event.description.strip]
          end
        end
      end
      format.html
    end
  end

  def create
  end

  private

  def restricted
    render(:text => 'Forbidden', :layout => true, :status => 403) unless current_user.can_download && current_user.can_edit_event
  end

  def set_tab
    @tab = :events
  end
end
