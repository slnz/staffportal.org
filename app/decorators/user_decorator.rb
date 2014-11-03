class UserDecorator < Draper::Decorator
  delegate_all

  def name
    return email if first_name.blank? || last_name.blank?
    "#{first_name} #{last_name}"
  end
end
