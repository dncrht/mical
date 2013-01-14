class Activity < ActiveRecord::Base
  validates :name, :presence => true
  validates :color, :format => /^#[0-9A-Fa-f]{6}$/
  validates :position, :numericality => true, :uniqueness => true
  
  has_many :events, :dependent => :destroy
  
  attr_accessible :name, :color, :position
end
