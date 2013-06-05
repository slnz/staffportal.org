ActiveAdmin.register Record, :as => "Transaction", :sort_order => :date do
  menu :parent => "Finance"

  action_item :only => :index do
    link_to 'Import from CSV', :action => 'upload_csv'
  end
  collection_action :upload_csv do
    render "accounts/import_records"
  end
  collection_action :import_csv, :method => :post do
    CsvDb.convert_save("record", params[:dump][:file])
    flash[:notice] = "CSV importing in background!"
    redirect_to :action => :index
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
    column :id
    column :account
    column :type
    column :date
    column(:amount) {|t| number_to_currency t.amount }
    column :balance
    default_actions
  end

  csv do
    column ("date") { |record| record.date.strftime('%d/%m/%y') }
    column :reason
    column("gl_code") { |record| "#{record.type.code}-#{record.account.code}" }
    column :amount
    column("reference") { |record| record.subtext }
    column :who
  end

end
