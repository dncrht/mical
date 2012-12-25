class Activity < ActiveRecord::Base
  validates :name, :presence => true
  validates :color, :format => /^#[0-9A-Fa-f]{6}$/
  
  has_many :events, :dependent => :destroy
  
  attr_accessible :name, :color
end
