class CreateEventActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :event_activities do |t|
      t.references :event, index: true, null: false
      t.references :activity, index: true, null: false

      t.timestamps
    end
  end
end
