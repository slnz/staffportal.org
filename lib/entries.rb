Account::Record.includes(:category, :account).all.map { |r|
  r.amount = 0 - r.amount if r.category_id == 161
  puts "#{r.date.strftime('%m/%d/%Y')},#{r.category.try(:code)},#{r.account.try(:code)},#{r.amount},#{r.id},\"#{r.reason.gsub('"', '\"')}\""
}
