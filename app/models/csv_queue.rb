class CsvQueue

  @queue = :csv_import

  def self.perform(model_name, group)
    group.each do |hash|
      target_model = model_name.classify.constantize
      new_object = target_model.new
      target_model.column_names.each do |key|
        case key
        when "ID"
          #do nothing
        when "amount"
          value = hash["amount"].gsub(/\,/,"").to_d
          new_object.send "#{key}=", value
        when "account_id"
          if hash.has_key?("gl_code")
            codes = hash["gl_code"].split(/-/)
            account = Account.where(:code => codes[1].gsub(/~/, '')).first
            new_object.account = account
          end
        when "type_id"
          if hash.has_key?("gl_code")
            codes = hash["gl_code"].split(/-/)
            type = Type.where(:code => codes[0]).first
            new_object.type = type
          end
        when "date"
          value = Date.strptime(hash["date"], '%d/%m/%y')
          new_object.send "#{key}=", value
        else
          if hash.has_key?(key)
            value = hash[key]
            new_object.send "#{key}=", value
          end
        end
      end
      new_object.save!
    end
  end
end
