class Usuario < ActiveRecord::Base
  set_table_name 'usuario'
  validates :email, :clave, :presence => true
  validates :email, :uniqueness => true
end
