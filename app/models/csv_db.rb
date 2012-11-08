require 'csv'
class CsvDb
  class << self
    def convert_save(model_name, csv_data)
      csv_file = csv_data.read
      Resque.enqueue(CsvQueue, model_name, csv_file)
    end
  end
end
