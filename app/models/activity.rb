class Activity < ActiveRecord::Base

  include Ordenable

  validates :name, :presence => true
  validates :color, :format => /\A#[0-9A-Fa-f]{6}\z/

  has_many :events, :dependent => :destroy
end
