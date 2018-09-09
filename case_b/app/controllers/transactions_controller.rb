class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user
      .account
      .transactions
      .includes(
        :account_recipient, 
        :account_sender
      )
  end

  def new
    @transaction = Transaction.new
    @users = User.where.not(id: current_user.id)
  end

  def create
    transaction = Transaction.new(transaction_params)
    account_transaction = AccountTransactionService.new(transaction)
    account_transaction.call
    
    if transaction.valid?
      redirect_back(
        fallback_location: root_path,
        notice: "#{transaction_params[:amount]} has been transfered to #{recipient_user.email}" # This should be moved to I18n
      )
    else
      redirect_back(fallback_location: root_path, alert: transaction.errors.full_messages.join(', ')) # This should be moved to I18n
    end
  end

private
  def recipient_account_id
    recipient_user.account.id
  end

  def recipient_user
    @recipient_user ||= User.find(params[:user_id])
  end

  def transaction_params
    params
      .require(:transaction)
      .permit(:amount)
      .merge(
        operation_type: :transfer,
        account_sender_id: current_user.account.id,
        account_recipient_id: recipient_account_id
      )
  end
end
