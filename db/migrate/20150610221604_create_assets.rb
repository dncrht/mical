class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.string :image_uid
      t.belongs_to :event

      t.timestamps
    end
  end
end
