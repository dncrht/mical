class Efemeride < ActiveRecord::Base
  set_table_name 'efemeride'
  set_primary_keys :dia
  validates :actividad, :resumen, :presence => true
end
