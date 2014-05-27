ActiveAdmin.register CurrencyRate do
  menu parent: 'Finance', label: 'Currency Rates'

  action_item only: :index do
    link_to 'Get Currencies Online', action: 'import_currency'
  end
  collection_action :import_currency do
    fx = OpenExchangeRates::Rates.new
    Currency.all.each do |currency|
      month = Time.now.beginning_of_month
      (1..12).each do
        CurrencyRate.where(
          currency_id: currency.id,
          month: month.end_of_day
        ).first_or_create(
          rate: fx.convert(1,
                           from: 'NZD',
                           to: currency.code,
                           on: month.strftime('%Y-%m-%d')
                          )
        )
        month = month.ago(1.month)
      end
    end
    flash[:notice] = 'Successfully imported Currency Rates'
    redirect_to action: :index
  end

  index do
    selectable_column
    column :currency
    column :month
    column :rate
    actions
  end

end
