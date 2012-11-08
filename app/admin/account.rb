ActiveAdmin.register Account do
  menu :parent => "Finance", :label => "Accounts"

  action_item :only => :index do
    link_to 'Import from CSV', :action => 'upload_csv'
  end
  collection_action :upload_csv do
    render "accounts/import_accounts"
  end
  collection_action :import_csv, :method => :post do
    CsvDb.convert_save("account", params[:dump][:file])
    flash[:notice] = "CSV importing in background!"
    redirect_to :action => :index
  end

  action_item :only => :index do
    link_to 'Recalculate Balances', :action => 'balances'
  end

  collection_action :balances do
    Account.all.each do |account|
      query = account.records.first
      Resque.enqueue(TransactionQueue, query) unless query.nil?
    end

    flash[:notice] = "Balances updating in background!"
    redirect_to :action => :index
  end

  index do
    selectable_column
    column :code
    column :name
    column("Balance") { |p|
                            acct = p.records.order('date DESC, id desc').first unless p.records.nil?
                            if acct.nil?
                              number_to_currency 0
                            else
                              @currency_rate = current_user.currency.currency_rates.where(:month => acct.month).first
                              @vehicle_advance = p.records.joins(:type).where("types.code" => "1225").sum(:amount)
                              @stock = p.records.joins(:type).where("types.code" => "1350").sum(:amount)
                              number_to_currency (acct.balance - @stock - @vehicle_advance) * @currency_rate.rate
                            end }
    default_actions
  end

end
