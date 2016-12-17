module ApplicationHelper
  def current_user_account
    return 'guest' unless current_user
    current_user.email.split('@')[0]
  end

  def tick_or_x(bool)
    bool ? '✓' : '✗'
  end
end
