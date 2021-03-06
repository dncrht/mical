class User < ApplicationRecord
  include Clearance::User

  before_destroy :at_least_one_admin

  def at_least_one_admin
    raise 'Must be at least one admin' if is_admin && User.where(is_admin: true).count == 1
  end
end
