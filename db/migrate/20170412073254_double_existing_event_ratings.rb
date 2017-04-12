class DoubleExistingEventRatings < ActiveRecord::Migration[5.0]
  def up
    transform_events :*
  end

  def down
    transform_events :/
  end

  def transform_events(operation)
    select_all('SELECT * FROM events').each do |event|
      next if event['rating'].nil?
      rating = event['rating'].send(operation, 2)
      update("UPDATE events SET rating=#{rating} WHERE id=#{event['id']}")
    end
  end
end
