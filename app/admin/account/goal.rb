ActiveAdmin.register Account::Goal do
  menu parent: 'Accounts', label: 'MPD Goals'

  action_item :import, only: :index do
    link_to 'Import from CSV', action: 'upload_csv'
  end
  collection_action :upload_csv do
    render 'accounts/import_goals'
  end
  collection_action :import_csv, method: :post do
    CsvDb.convert_save('account::goal', params[:dump][:file])
    flash[:notice] = 'CSV importing in background!'
    redirect_to action: :index
  end

  index do
    selectable_column
    column :account
    column :category
    column :amount
    actions
  end
end
