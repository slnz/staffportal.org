require 'csv'
class CsvDb
  class << self
    def convert_save(model_name, csv_data)
      csv_file = csv_data.read
      CSV.parse(csv_file, :headers => true) do |row|
        hash = row.to_hash
        target_model = model_name.classify.constantize
        new_object = target_model.new
        target_model.column_names.each do |key|
          case key
          when "ID"
            #do nothing
          when "type_name"
            #do nothing
          when "amount"
            value = hash["amount"].gsub(/\,/,"").to_d
            new_object.send "#{key}=", value
          when "account_id"
            value = Account.where(:code => hash['account']).first_or_create
            new_object.send "#{key}=", value
          when "type_id"
            if hash.has_key?("type_name") and hash.has_key?("type")
              value = Type.where(:name => hash["type_name"]).first_or_create do |type|
                if hash["type"].downcase == "income"
                  type.is_income = true
                else
                  type.is_income = false
                end
              end
              new_object.send "#{key}=", value.id
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
        new_object.save
      end
    end
  end
end
