ActiveAdmin.register Record do
  menu :parent => "Finance", :label => "Transactions"

  action_item :only => :index do
    link_to 'Import from CSV', :action => 'upload_csv'
  end
  collection_action :upload_csv do
    render "accounts/import_records"
  end
  collection_action :import_csv, :method => :post do
    CsvDb.convert_save("record", params[:dump][:file])
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end

  form do |f|
    f.inputs "Details" do
      f.input :account
      f.input :type
      f.input :date, :as => 'datepicker'
      f.input :amount
      f.input :reason
      f.input :who
      f.input :subtext
    end
    f.buttons
  end

  index do
    selectable_column
    column :account
    column :type
    column :date
    column(:amount) {|t| number_to_currency t.amount }
    column(:balance) {|t| number_to_currency t.balance }
    default_actions
  end

end
