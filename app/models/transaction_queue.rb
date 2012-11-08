class TransactionQueue

  @queue = :balances

  def self.perform(record)
    record.update_external_balances
  end
end
