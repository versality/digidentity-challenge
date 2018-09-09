class AccountTransactionService
  def initialize(transaction)
    @transaction = transaction
  end

  def call
    send(transaction.operation_type)
  end

  protected
  # As amount of operation types will grow, these should be moved out to a separate class
  def deposit
    transact do
      account_deposit
    end
  end

  def transfer
    transact do
      account_withdraw
      account_deposit
    end
  end

  private
  def account_withdraw
    transaction.account_sender.withdraw(transaction.amount)
  end

  def account_deposit
    transaction.account_recipient.deposit(transaction.amount)
  end

  def transaction
    @transaction
  end

  def transact
    Transaction.transaction do
      yield
      raise ActiveRecord::Rollback unless transaction.save
    end
  end
end