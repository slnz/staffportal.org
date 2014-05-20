ActiveAdmin.register Type do
  menu parent: 'Finance', label: 'Transaction Types'

  action_item only: :index do
    link_to 'Import from CSV', action: 'upload_csv'
  end
  collection_action :upload_csv do
    render 'accounts/import_types'
  end
  collection_action :import_csv, method: :post do
    CsvDb.convert_save('type', params[:dump][:file])
    flash[:notice] = 'CSV importing in background!'
    redirect_to action: :index
  end

  filter :code
  filter :name
  filter :definition

  index do
    selectable_column
    column :code
    column :name
    column :definition
    default_actions
  end
end
