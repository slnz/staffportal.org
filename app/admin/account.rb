ActiveAdmin.register Account, as: 'Responsibility Center' do
  menu parent: 'Accounts'
  permit_params :name, :code, :currency

  action_item :import, only: :index do
    link_to 'Import from CSV', action: 'upload_csv'
  end

  collection_action :upload_csv do
    render 'accounts/import_accounts'
  end

  collection_action :import_csv, method: :post do
    Job::CsvDb.convert_save('account', params[:dump][:file])
    flash[:notice] = 'CSV importing in background!'
    redirect_to action: :index
  end

  action_item :recalculate, only: :index do
    link_to 'Recalculate Balances', action: 'balances'
  end

  collection_action :balances do
    Account.all.each do |account|
      Resque.enqueue(Job::TransactionQueue, account.id)
    end

    flash[:notice] = 'Balances updating in background!'
    redirect_to action: :index
  end

  filter :code
  filter :name

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :code
      f.input :currency,
              as: :select,
              collection: CurrencySelect.currencies_array
    end
    f.actions
  end

  index do
    selectable_column
    column :code
    column :name
    column('Currency') do |p|
      p.currency.upcase
    end
    column('Balance') do |p|
      number_to_currency(
        p.records.order('date desc, id desc').last.try(:balance) || 0)
    end
    actions
  end
end
