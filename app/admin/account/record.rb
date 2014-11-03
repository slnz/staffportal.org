ActiveAdmin.register Account::Record, as: 'Transaction', sort_order: :date do
  config.sort_order = 'id_desc'
  menu parent: 'Accounts'
  permit_params :account_id,
                :category_id,
                :date,
                :amount,
                :reason,
                :who,
                :subtext
  action_item only: :index do
    link_to 'Import from CSV', action: 'upload_csv'
  end
  collection_action :upload_csv do
    render 'accounts/import_records'
  end
  collection_action :import_csv, method: :post do
    CsvDb.convert_save('record', params[:dump][:file])
    flash[:notice] = 'CSV importing in background!'
    redirect_to action: :index
  end

  form do |f|
    f.inputs 'Details' do
      f.input :account
      f.input :category
      f.input :date, as: 'datepicker'
      f.input :amount
      f.input :reason
      f.input :who
      f.input :subtext
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :account
    column :category
    column :date
    column(:amount) { |t| number_to_currency t.amount }
    column :balance
    actions
  end

  csv do
    column('date') { |record| record.date.strftime('%d/%m/%y') }
    column :reason
    column('gl_code') do |record|
      "#{record.category.code}-#{record.account.code}"
    end
    column :amount
    column('reference') { |record| record.subtext }
    column :who
  end

end
