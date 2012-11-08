require 'csv'
class CsvDb
  class << self
    def convert_save(model_name, csv_data)
      rows = []
      parsed_csv = CSV.parse(csv_data.read, :headers => true) do |row|
        rows.push row.to_hash
      end

      rows.in_groups_of(50, false) { |group|
        Resque.enqueue(CsvQueue, model_name, group)
      }
    end
  end
end
