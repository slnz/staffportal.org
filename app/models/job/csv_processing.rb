class Job
  class CsvProcessing < Job
    include Resque::Plugins::Status
    @queue = :csv_import
    @retry_limit = 1

    def perform
      target_model = options['model_name'].classify.constantize
      hash = options['row']
      new_object = target_model.new
      target_model.column_names.each do |key|
        case key.downcase
        when 'id'
          # do nothing
        when 'amount'
          new_object.send "#{key}=", hash['amount'].gsub(/\, /, '').to_d
        when'account_id'
          break unless hash.key?('responsibility_center_code')
          new_object.account =
            Account.find_by(code: hash['responsibility_center_code'])
        when 'category_id'
          break unless hash.key?('ledger_code')
          new_object.category =
            Account::Category.find_by(code: hash['ledger_code'])
        when 'date'
          new_object.send "#{key}=", Date.strptime(hash['date'], '%d/%m/%y')
        else
          new_object.send "#{key}=", hash[key] unless hash.key?(key)
        end
      end
      new_object.save!
    end
  end
end
