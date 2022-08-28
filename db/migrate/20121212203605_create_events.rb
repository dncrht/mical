class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.date :day
      t.integer :activity_id
      t.text :description
    end

    add_index :events, :day
  end
end
