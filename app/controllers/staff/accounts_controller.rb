module Staff
  class AccountsController < StaffController
    add_breadcrumb 'accounts', :accounts_path
    respond_to :html, only: [:index, :show]
    before_action :authenticate_user!

    def index
      load_accounts
    end

    def show
      @totals = {}
      load_account
      add_breadcrumb @account.code, account_path(@account)
    end

    def transactions
      load_account
      load_transactions
      add_breadcrumb @account.code, account_path(@account)
      add_breadcrumb 'history', transactions_account_path(@account)
    end

    protected

    def load_accounts
      @accounts ||= accounts_scope.decorate
    end

    def load_account
      @account ||= AccountDecorator.decorate(accounts_scope.find(params[:id]))
    end

    def load_transactions
      query = @account.records
      unless params[:month].nil?
        query =
          query.where(month:
            Date.strptime(params[:month], '%b %y').beginning_of_month)
      end
      query = query.where(category_id: params[:category]) if params[:category]
      @transactions =
        query.order('date DESC, id DESC').includes(:category).page params[:page]
      @money_in = 0
      @money_out = 0
      @transactions.each do |t|
        if t.category.income?
          @money_in += t.amount
        elsif t.category.current_liability?
          @money_in += t.amount
        elsif t.category.expense?
          @money_out -= t.amount
        end
      end
    end

    def accounts_scope
      current_user.accounts.order(:code)
    end

    def user_type
      :account_holder
    end
  end
end
