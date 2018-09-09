class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, ->(account) { 
    unscope(:where).where('account_recipient_id = :id OR account_sender_id = :id', id: account.id) 
  }

  validates :balance, numericality: { greater_than_or_equal_to: 0.0 }

  # Using BigDecimal since float is not a good option for calculating money
  def deposit(amount)
    result = BigDecimal.new(balance) + BigDecimal.new(amount)
    update_attributes(balance: result)
  end

  def withdraw(amount)
    result = BigDecimal.new(balance) - BigDecimal.new(amount)
    update_attributes(balance: result)
  end
end
