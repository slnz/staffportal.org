class AccountsController < ApplicationController
  before_filter :authenticate_user!
  def index

  end
  def transactions
    @account = current_user.accounts.find(params[:id])
    @transactions = @account.records.order('date DESC, id ASC').page params[:page]

    @money_in = 0;
    @money_out = 0;
    @transactions.each do |t|
      if t.type.is_income
        @money_in += t.amount
      else
        @money_out -= t.amount
      end
    end
  end
  def show
    @account = current_user.accounts(params[:id]).first
  end
end
