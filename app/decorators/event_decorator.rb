class EventDecorator < ApplicationDecorator
  delegate_all

  def registered?(current_user)
    !registrations.find_by(user: current_user).blank?
  end
end
