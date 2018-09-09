require 'rails_helper'

describe AccountTransactionService do
  describe '#call' do
    context 'deposit' do
      it 'should deposit money to recipient' do
        topup_amount = 500
        
        account = create(:account)

        transaction = build(:transaction, 
          account_recipient_id: account.id,
          amount: topup_amount,
          operation_type: :deposit
        )

        account_transaction = AccountTransactionService.new(transaction)
        account_transaction.call
        
        account.reload
        expect(account.balance).to eq(topup_amount)
      end
    end

    context 'transfer' do
      def transfer_money(balance, amount)
        recipient_account = create(:account)
        sender_account = create(:account, balance: balance)

        transaction = build(:transaction, 
          account_recipient_id: recipient_account.id,
          account_sender_id: sender_account.id,
          amount: amount,
          operation_type: :transfer
        )

        account_transaction = AccountTransactionService.new(transaction)
        account_transaction.call
        
        return recipient_account.reload, sender_account.reload
      end

      it 'should transfer money from sender to recipient' do
        recipient_account, sender_account = transfer_money(500, 200)
        expect(recipient_account.balance).to eq(200)
        expect(sender_account.balance).to eq(300)
      end

      context 'when balance is lower than transfer amount' do
        it 'should not change balance' do
          recipient_account, sender_account = transfer_money(50, 200)
          expect(recipient_account.balance).to eq(0)
          expect(sender_account.balance).to eq(50)
        end

        it 'should not create transaction' do
          expect { transfer_money(50, 200) }.to_not change { Transaction.count }
        end
      end
    end
  end
end