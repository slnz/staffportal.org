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

end
