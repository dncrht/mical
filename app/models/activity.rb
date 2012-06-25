class Activity < ActiveRecord::Base
  validates :name, :presence => true
  validates :color, :format => /^[A-Fa-f]{6}$/
  
  attr_accessible :name, :color
end
