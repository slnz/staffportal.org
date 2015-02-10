class Job
  class CsvProcessing < Job
    include Resque::Plugins::Status
    @queue = :csv_import

    def perform
      target_model = options['model_name'].classify.constantize
      hash = options['row']
      new_object = target_model.new
      target_model.column_names.each do |key|
        case key.downcase
        when 'id'
          # do nothing
        when 'amount'
          value = hash['amount'].gsub(/\, /, '').to_d
          new_object.send "#{key}=", value
        when'account_id'
          if hash.key?('gl_code')
            codes = hash['gl_code'].split(/-/)
            account = Account.where(code: codes[1].gsub(/~/, '')).first
            new_object.account = account
          end
        when 'category_id'
          if hash.key?('gl_code')
            codes = hash['gl_code'].split(/-/)
            category = Account::Category.where(code: codes[0]).first
            new_object.category = category
          end
        when 'date'
          value = Date.strptime(hash['date'], '%d/%m/%y')
          new_object.send "#{key}=", value
        else
          if hash.key?(key)
            value = hash[key]
            new_object.send "#{key}=", value
          end
        end
      end
      new_object.save!
    end
  end
end
