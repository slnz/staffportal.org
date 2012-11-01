ActiveAdmin.register Record do
  menu :parent => "Finance", :label => "Transactions"
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
end
