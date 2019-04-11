module Sortable
  extend ActiveSupport::Concern

  included do
    default_scope { order(:position) }
    before_save :set_position
    after_save :reorder
    validate :multiple_of_five, on: :update
  end

  private

  def multiple_of_five
    if position.to_i % 5 != 0
      errors.add(:position, 'must be multiple of 5')
    end
  end

  def set_position
    if position.nil?
      self.position = self.class.maximum(:position).to_i + 10
    end
  end

  def reorder
    self.class.all.each_with_index do |entity, index|
      entity.update_column(:position, (index + 1) * 10)
    end
  end
end
