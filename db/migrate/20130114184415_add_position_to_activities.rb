class AddPositionToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :position, :integer
  end
end
