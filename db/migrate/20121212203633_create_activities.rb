class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.text :name
      t.text :color
    end
  end
end
