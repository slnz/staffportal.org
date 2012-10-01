class BootcampController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter
  def index
    @week6 = Week6.where(:user_id => User.find(session[:user_id])).first_or_create
  end
  def week6
    @week6 = Week6.where(:user_id => User.find(session[:user_id])).first_or_create
  end
  def contacts
    @contacts = Contact.where(:user_id => User.find(session[:user_id])).all
  end
end
