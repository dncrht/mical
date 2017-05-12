class Activity < ApplicationRecord
  include Sortable

  validates :name, presence: true
  validates :color, format: /\A#[0-9A-Fa-f]{6}\z/

  has_many :events, dependent: :destroy

  def count_during_year(year)
    Event
      .where(
        'activity_id = ? AND day >= ? AND day <= ?',
        id,
        Date.new(year, 1, 1),
        Date.new(year, 12, 31)
      )
      .count
  end
end
