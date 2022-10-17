class User < ApplicationRecord
  before_destroy :at_least_one_admin

  has_secure_password

  validates :email, presence: true, uniqueness: { allow_blank: true }, format: { with: /\A(.+)@(.+)\z/ }

  def at_least_one_admin
    raise 'Must be at least one admin' if is_admin && User.where(is_admin: true).count == 1
  end
end
