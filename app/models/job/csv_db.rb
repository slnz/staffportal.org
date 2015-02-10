require 'csv'
class Job
  class CsvDb
    def self.convert_save(model_name, csv_data)
      rows = []
      CSV.parse(csv_data.read,
                headers: true,
                header_converters: ->(h) { h.try(:downcase) }) do |row|
        rows.push row.to_hash
      end

      rows.each do |row|
        Job::CsvProcessing.create(model_name: model_name, row: row)
      end
    end
  end
end
