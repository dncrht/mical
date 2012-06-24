class User < ActiveRecord::Base
  validates :email, :clave, :presence => true
  validates :email, :uniqueness => true
end
