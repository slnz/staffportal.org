class StaffController < ApplicationController
  before_action :authenticate_user!

  def current_account_holder
    current_user.as :account_holder
  end
end
