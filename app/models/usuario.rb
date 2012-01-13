class Usuario < ActiveRecord::Base
  set_table_name 'usuario'
  validates :email, :presence => true
  validates :email, :uniqueness => true
  validates :clave, :presence => true, :if => Proc.new {|user| user.email != 'guest'}
end
