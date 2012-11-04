class AccountsController < ApplicationController
  before_filter :authenticate_user!
  def index

  end
  def transactions
    @account = current_user.accounts.find(params[:id])

    query = @account.records
    unless params[:type].nil?
      @type_id = Type.where(:name => params[:type]).first
      params[:type_id] = @type_id.id unless @type_id.nil?
    end
    query = query.where(:type_id => params[:type_id]) unless params[:type_id].nil?
    query = query.where(:month => Date.parse(params[:month], '%b %y').beginning_of_month ) unless params[:month].nil?
    @transactions = query.order('date DESC, id ASC').page params[:page]

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
    @account = current_user.accounts.find(params[:id])
    @transactions = @account.records.where("month <= ? and month >= ?",Time.now.end_of_month, Time.now.ago(11.month).beginning_of_month).limit(500).joins(:type).select("types.name, types.is_income, records.month, sum(records.amount) as amount").group("types.id, types.name, records.month, types.is_income").order("records.month desc, types.is_income desc, types.name")

    @months = {}

    @day = Time.now.ago(11.month).beginning_of_month
    (1..12).each do |t|
      @months[@day.strftime('%b %y')] = 0
      @day += 1.month
    end

    @income_summary = @months.deep_dup
    @expense_summary = @months.deep_dup

    @income = {}
    @expense = {}
    @transactions.each do |t|
      if t.is_income == 't'
        @income[t.name] = @months.deep_dup if @income[t.name].blank?
        @income[t.name][t.month.strftime('%b %y')] = t.amount
      else
        @expense[t.name] = @months.deep_dup if @expense[t.name].blank?
        @expense[t.name][t.month.strftime('%b %y')] = t.amount
      end
    end
  end
end
