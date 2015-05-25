class UserDecorator < ApplicationDecorator
  def name
    return email if first_name.blank? || last_name.blank?
    "#{first_name.titleize} #{last_name.titleize}"
  end

  def initials
    first_name[0, 1] + last_name[0, 1]
  end
end
