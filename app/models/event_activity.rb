class EventActivity < ApplicationRecord
  belongs_to :event, optional: true
  belongs_to :activity, optional: true
end
