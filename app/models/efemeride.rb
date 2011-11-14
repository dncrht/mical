class Efemeride < ActiveRecord::Base
  set_table_name 'efemeride'
  set_primary_keys :dia
  validates :dia, :actividad_id, :resumen, :presence => true
end
