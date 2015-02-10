ActiveAdmin.register Account::Category, as: 'Ledger Code' do
  menu parent: 'Accounts'
  permit_params :name, :code, :state, :effect, :salary, :cumulative

  action_item :import, only: :index do
    link_to 'Import from CSV', action: 'upload_csv'
  end
  collection_action :upload_csv do
    render 'accounts/import_types'
  end
  collection_action :import_csv, method: :post do
    Job::CsvDb.convert_save('Account::Category', params[:dump][:file])
    flash[:notice] = 'CSV importing in background!'
    redirect_to action: :index
  end

  filter :code
  filter :name

  index do
    selectable_column
    column :code
    column :name
    column :state
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :code
      f.input :name
      f.input :state, as: :select, collection: Account::Category.states.keys
      f.input :effect, as: :select, collection: Account::Category.effects.keys
      f.input :salary
      f.input :cumulative
    end
    f.actions
  end
end
