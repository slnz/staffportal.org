module Staff
  class AccountsController < ApplicationController
    include InheritedResources::DSL

    add_breadcrumb 'my accounts', :staff_accounts_path

    respond_to :html, only: [:index, :show]
    before_filter :authenticate_user!
    def index
      # 160 is the ID of the advances type, 243 is the PI advances type
      @advances = current_user.accounts.
                               joins(:records).
                               where('records.type_id = 160 ' +
                                     'or records.type_id = 243').
                               group('accounts.id').
                               sum('records.amount')

      @graphs = {}
      @months = {}
      (1..12).each do |count|
        @months[DateTime.now.
                         beginning_of_month.
                         ago((13 - count).month).
                         strftime('%b %y')] = 0
      end
      if current_user.currency.nil?
        current_user.currency = Currency.find_by_code('NZD')
        current_user.save
      end
      @currency_rate = current_user.currency.currency_rates.order(:month).last
      @currency_rate = @currency_rate.blank? ? 1 : @currency_rate.rate
      if current_user.accounts.count <= 15
        @goals = current_user.accounts.
                              joins(goals: :type).
                              where("types.definition = 'IN'").
                              group('accounts.id').
                              sum(:amount)
        @salary = current_user.accounts.
                               joins(goals: :type).
                               where("types.name = 'Salary'").
                               group('accounts.id').
                               sum(:amount)
        current_user.accounts.
                     joins(:records).
                     group([:code, :month, 'records.date', 'records.id']).
                     order('records.date', 'records.id').
                     select('records.id, code, month, last(balance)').
                     each do |value|
                       unless @graphs.has_key?(value.code)
                         @graphs[value.code] = @months.deep_dup
                       end
                       string_month = value.month.strftime('%b %y')
                       if @graphs[value.code].has_key?(string_month)
                         @graphs[value.code][string_month] = value.last.to_i *
                                                            @currency_rate
                       end
                     end
      end
    end

    def change_default_currency
      if current_user.currency.nil?
        current_user.currency = Currency.where(code: 'NZD').
                                         first_or_create(name: 'New Zealand ' +
                                                         'Dollar')
      end
      current_user.currency = Currency.where(code: params[:code]).first
      current_user.save
      respond_to do |format|
        format.json { render json: 'success' }
      end
    end

    def transactions
      @account = current_user.accounts.find(params[:id])
      add_breadcrumb @account.code, staff_account_path(@account)
      add_breadcrumb 'transactions', transactions_staff_account_path(@account)

      @currency_rate = current_user.currency.currency_rates.order(:month).last
      @currency_rate = @currency_rate.blank? ? 1 : @currency_rate.rate
      query = @account.records
      unless params[:type].nil?
        @type_id = Type.where(id: params[:type]).first
      end
      query = query.where(type_id: @type_id.id) unless @type_id.nil?
      unless params[:month].nil?
        query = query.where(month: Date.strptime(params[:month], '%b %y').
                                        beginning_of_month)
      end
      @transactions = query.order('date DESC, id DESC').
                            includes(:type).
                            page params[:page]
      @money_in = 0
      @money_out = 0
      @transactions.each do |t|
        if t.type.income?
          @money_in += t.amount
        elsif t.type.expense?
          @money_out -= t.amount
        end
      end

      @fullwidth = true
    end

    def show
      @account = current_user.accounts.find(params[:id])
      add_breadcrumb @account.code, staff_account_path(@account)
      add_breadcrumb 'transactions', transactions_staff_account_path(@account)

      @months_to_show = 11
      @latest = @account.records.order(:date).last
      @transactions = @account.records.
                               where('month <= ? and month >= ?',
                                     @latest.date.end_of_month,
                                     @latest.date.
                                             ago(@months_to_show.month).
                                             beginning_of_month).
                               limit(500).
                               joins(:type).
                               select('types.id, types.code, types.name, ' +
                                      'types.definition, records.month, ' +
                                      'sum(records.amount) as amount').
                               group('types.code, types.id, types.name, ' +
                                     'records.month, types.definition').
                               order('types.code asc, records.month desc, ' +
                                     'types.definition desc')
      @goals = {}
      @account.goals.all.each do |value|
        @goals[value.type.id.to_s] = value.amount
      end
      @months = {}

      @currency_summary = {}

      fx = OpenExchangeRates::Rates.new

      @day = @latest.date.ago((@months_to_show).month).beginning_of_month
      (0..@months_to_show).each do
        @months[@day.strftime('%b %y')] = 0
        @currency_summary[@day.strftime('%b %y')] = 1
        unless current_user.currency_code == 'NZD'
          @query = current_user.currency.
                                currency_rates.
                                where(month: @day.end_of_day).
                                first_or_create(
                                rate: fx.convert(1,
                                                 from: 'NZD',
                                                 to: current_user.currency_code,
                                                 on: @day.strftime('%Y-%m-%d')))
          unless @query.nil?
            @currency_summary[@day.strftime('%b %y')] = @query.rate
          end
        end

        @day += 1.month
      end
      @day -= 1.month # last

      @income_summary = @months.deep_dup
      @expense_summary = @months.deep_dup
      @advance_summary = @months.deep_dup

      @income = {}
      @expense = {}
      @advance = {}

      @income_goal = 0
      @expense_goal = 0

      @vehicle_advances = @account.records.
                                   where('month < ? and type_id = 161',
                                         @latest.date.
                                                 ago(@months_to_show.month).
                                                 beginning_of_month).
                                   sum(:amount)
      @stock_advances = @account.records.
                                 where('month < ? and type_id = 163',
                                       @latest.date.
                                               ago(@months_to_show.month).
                                               beginning_of_month).
                                 sum(:amount)
      @transactions.each do |t|
        if t.definition == 'IN' ||
           t.code == '1301' ||
           t.code == 'P1301'
          if @income[t.id.to_s].blank?
            @income[t.id.to_s] = @months.deep_dup.merge(name: t.name)
          end
          if @currency_summary[t.month.strftime('%b %y')].nil?
            fail t.month.strftime('%b %y').inspect
          end
          @income[t.id.to_s][t.month.strftime('%b %y')] =
            t.amount * @currency_summary[t.month.strftime('%b %y')]
        elsif t.definition == 'EX'
          @expense[t.id.to_s] =
            @months.deep_dup.merge(name: t.name) if @expense[t.id.to_s].blank?
          @expense[t.id.to_s][t.month.strftime('%b %y')] =
            t.amount * @currency_summary[t.month.strftime('%b %y')]
        elsif t.code == '1220' ||
              t.code == '1350' ||
              t.code == '1225' ||
              t.code == 'P1210'
          @advance[t.id.to_s] =
            @months.deep_dup.merge(name: t.name) if @advance[t.id.to_s].blank?
          @advance[t.id.to_s][t.month.strftime('%b %y')] = t
        end
      end

      @fullwidth = true
    end
  end
end
