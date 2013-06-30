class Activity < ActiveRecord::Base
  validates :name, :presence => true
  validates :color, :format => /\A#[0-9A-Fa-f]{6}\z/
  validates :position, :numericality => true, :uniqueness => true
  
  has_many :events, :dependent => :destroy
end
