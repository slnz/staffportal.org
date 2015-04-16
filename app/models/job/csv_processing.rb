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
          if hash.key?('responsibility_center_code')
            new_object.account =
              Account.find_by(code: hash['responsibility_center_code'])
          elsif hash.key?('gl_code')
            codes = hash['gl_code'].split(/-/)
            account = Account.where(code: codes[1].gsub(/~/, '')).first
            new_object.account = account
          end
        when 'category_id'
          if hash.key?('ledger_code')
            new_object.category =
              Account::Category.find_by(code: hash['ledger_code'])
          elsif hash.key?('gl_code')
            codes = hash['gl_code'].split(/-/)
            category = Account::Category.where(code: codes[0]).first
            new_object.category = category
          end
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