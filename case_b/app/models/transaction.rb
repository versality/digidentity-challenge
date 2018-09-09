class Transaction < ApplicationRecord
  belongs_to :account_recipient, class_name: 'Account', foreign_key: 'account_recipient_id'
  belongs_to :account_sender, class_name: 'Account', foreign_key: 'account_sender_id', optional: true

  validates :amount, numericality: { greater_than: 0.0 }

  enum operation_type: [:deposit, :transfer]

  validates_associated [:account_sender, :account_recipient], message: ->(klass, obj) { 
    obj[:value].errors.full_messages.join(',') 
  }
end
