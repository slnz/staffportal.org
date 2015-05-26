class AccountDecorator < ApplicationDecorator
  def name
    "#{code} - #{object.name}"
  end

  alias_method :label, :name

  def balance
    records.last.nil? ? 0 : records.last.balance
  end

  def advance_balance
    records.where('category_id = 160 or category_id = 243').sum('amount')
  end

  def goal
    goals.income.sum(:amount).to_i
  end

  def salary
    goals.salary.sum(:amount).to_i
  end

  def months
    @months = {}
    (0..11).each do |count|
      @months[(last_updated - (11 - count).months).strftime('%b %y')] = 0
    end
    @months
  end

  def summary
    summary = records.unscoped
      .from("(#{Account::Record.where(account_id: id).to_sql}) as r")
      .group('date_trunc(\'month\', date)')
      .where('r.date >= ?',
             last_updated - 11.months)
      .order('last(date)')
      .pluck('last(CAST(balance AS integer))').map {|e| e ? e : 0}
    padding = []
    (1..12 - summary.size).each { |_index| padding += [0] }
    padding + summary
  end

  def list_category(category)
    data = process_data_from_category(data_from_category(category), category)
    return data.merge(name: category.to_s.titleize) if data
  end

  def last_updated
    records.last.nil? ? Time.now.end_of_month : records.last.date.end_of_month
  end

  def last_updated_string
    last_updated.try(:strftime, '%b %Y')
  end

  private

  def data_from_category(category)
    inner_query =
      Account::Record.try(category).where('account_id = ? and date >= ?',
                                          id, last_updated - 11.months).to_sql
    records
      .unscoped
      .from("(#{inner_query}) as r")
      .group(:category_id, 'date_trunc(\'month\', date)')
      .where('r.date >= ?', last_updated - 11.months)
      .order('r.category_id, last(date)')
      .pluck('date_trunc(\'month\', date)', 'r.category_id', 'sum(CAST(amount AS integer))')
  end

  def process_data_from_category(data, category)
    return if data.empty?
    returnable = {}
    totals =
      { name: category.to_s.titleize, data: months, current: 0,
        goal: 0, graph_id: SecureRandom.uuid }
    data.each { |row| process_block(row, returnable, totals) }
    { monthly: returnable, totals: totals }
  end

  def process_block(row, returnable, totals)
    unless returnable[row[1]]
      goal = goals.find_by(category_id: row[1]).try(:amount).to_i
      totals[:goal] += goal
      returnable[row[1]] ||= create_category_stub(row[1], goal)
    end
    returnable[row[1]][:data][row[0].strftime('%b %y')] = row[2]
    totals[:data][row[0].strftime('%b %y')] += row[2]
    returnable[row[1]][:current] += row[2]
    totals[:current] += row[2]
  end

  def create_category_stub(category_id, goal)
    {
      category_id: category_id,
      data: months,
      name: Account::Category.find(category_id).name,
      current: 0,
      goal: goal,
      graph_id: SecureRandom.uuid
    }
  end
end
