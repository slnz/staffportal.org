class EventDecorator < ApplicationDecorator
  def registered?(current_user)
    !registrations.find_by(user: current_user).blank?
  end
end
