require 'csv'
class CsvDb
  class << self
    def convert_save(model_name, csv_data)
      rows = []
      CSV.parse(csv_data.read,
                headers: true,
                header_converters: lambda { |h| h.try(:downcase) }) do |row|
        rows.push row.to_hash
      end

      rows.each do |row|
        Resque.enqueue(CsvQueue, model_name, row)
      end
    end
  end
end
