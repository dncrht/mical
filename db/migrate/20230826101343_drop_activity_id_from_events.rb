class DropActivityIdFromEvents < ActiveRecord::Migration[7.0]
  def up
    Event.all.each do |event|
      EventActivity.create(event_id: event.id, activity_id: event.activity_id).errors
    end

    remove_column :events, :activity_id, :integrer
  end

  def down
    add_column :events, :activity_id, :integrer
  end
end
