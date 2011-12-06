class Usuario < ActiveRecord::Base
  set_table_name 'usuario'
  validates :email, :clave, :presence => true
  validates :email, :exclusion => {:in => %w(admin guest), :message => 'Username %{value} is reserved'}
end
