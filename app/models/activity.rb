class Activity < ActiveRecord::Base
  validates :name, :presence => true
  validates :color, :format => /^[0-9A-Fa-f]{6}$/
  
  attr_accessible :name, :color
end
