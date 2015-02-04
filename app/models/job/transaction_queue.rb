class TransactionQueue < Job
  @queue = :balances

  def self.perform(id)
    account = Account.find(id)
    account.update_balance
  end
end
