class AddRatingToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :rating, :integer
  end
end
