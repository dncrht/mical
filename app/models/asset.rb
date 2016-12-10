class Asset < ApplicationRecord
  dragonfly_accessor :image
  validates_presence_of :image

  belongs_to :event
end
