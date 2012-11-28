class BootcampController < ApplicationController
  before_filter :authenticate_user!
  def index
    @week6 = Week6.where(:user_id => User.find(current_user.id)).first_or_create
    @week5 = Week5.where(:user_id => User.find(current_user.id)).first_or_create
  end
  def week6
    @week6 = Week6.where(:user_id => User.find(current_user.id)).first_or_create
  end
  def week5
    @week5 = Week5.where(:user_id => User.find(current_user.id)).first_or_create
  end
  def contacts
    @contacts = current_user.contacts.order(:created_at).reverse_order
  end
end
