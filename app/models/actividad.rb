class Actividad < ActiveRecord::Base
  set_table_name 'actividad'
  validates :nombre, :presence => true
end
