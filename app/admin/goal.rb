ActiveAdmin.register Goal do
  menu parent: 'Finance', label: 'MPD Goals'

  action_item only: :index do
    link_to 'Import from CSV', action: 'upload_csv'
  end
  collection_action :upload_csv do
    render 'accounts/import_goals'
  end
  collection_action :import_csv, method: :post do
    CsvDb.convert_save('goal', params[:dump][:file])
    flash[:notice] = 'CSV importing in background!'
    redirect_to action: :index
  end

  index do
    selectable_column
    column :account
    column :type
    column :amount
    default_actions
  end
end
