class Staff::AccountsController < StaffController
  add_breadcrumb 'my accounts', :accounts_path
  respond_to :html, only: [:index, :show]
  before_action :authenticate_user!

  def index
    load_accounts
  end

  def show
    load_account
    add_breadcrumb @account.code, account_path(@account)
  end

  protected

  def load_accounts
    @accounts ||= accounts_scope.decorate
  end

  def load_account
    @account ||= AccountDecorator.decorate(accounts_scope.find(params[:id]))
  end

  def accounts_scope
    current_account_holder.accounts
  end
end
