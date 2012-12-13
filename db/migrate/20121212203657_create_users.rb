class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email
      t.text :password
      t.boolean :can_download
      t.boolean :can_edit_activity
      t.boolean :can_edit_event
      t.boolean :can_see_legend
      t.boolean :can_see_description
    end
  end
end
