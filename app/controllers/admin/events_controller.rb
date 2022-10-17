class Admin::EventsController < AdminController
  set_tab :events
  access_to { |user| user.can_download && user.can_edit_event }

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
    Event.delete_all

    CSV.foreach(params[:file].tempfile.path, headers: false, col_sep: "\t") do |row|
      Event.create(
        day: row[0],
        activity_id: Activity.find_by(name: row[1]).id,
        description: row[2]
      )
    end

    redirect_to root_path
  end
end
