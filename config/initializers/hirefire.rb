
HireFire::Resource.configure do |config|
  config.dyno(:csv_import) do
    HireFire::Macro::Resque.queue(:csv_import)
  end

  config.dyno(:balances) do
    HireFire::Macro::Resque.queue(:balances)
  end

  config.dyno(:statused) do
    HireFire::Macro::Resque.queue(:statused)
  end
end
