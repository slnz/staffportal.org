class BootcampController < ApplicationController
  before_filter :authenticate_user!
  def index
    @week6 = Week6.where(:user_id => User.find(current_user.id)).first_or_create
  end
  def week6
    @week6 = Week6.where(:user_id => User.find(current_user.id)).first_or_create
  end
  def contacts
    @contacts = current_user.contacts
  end
end
