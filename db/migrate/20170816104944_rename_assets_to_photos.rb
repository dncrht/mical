class RenameAssetsToPhotos < ActiveRecord::Migration[5.1]
  def change
    rename_table :assets, :photos
  end
end
