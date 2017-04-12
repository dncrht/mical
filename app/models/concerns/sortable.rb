module Sortable
  extend ActiveSupport::Concern

  included do
    before_save :set_position
    after_save :reorder
    validate :position_is_multiple_of_five, on: :update
  end

  private

  def position_is_multiple_of_five
    if position.to_i % 5 != 0
      errors.add(:position, 'should be multiple of 5')
    end
  end

  def set_position
    if position.nil?
      self.position = self.class.select('MAX(position) AS max').order(nil).first.max.to_i + 10
    end
  end

  def reorder
    new_position = 10
    self.class.order('position').each do |i|
      i.update_column :position, new_position
      new_position += 10
    end
  end
end
