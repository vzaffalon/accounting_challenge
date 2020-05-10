require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "AccountTransfer", type: :model do

    describe "create" do

        before do
            @user = User.create(
                name: 'Victor Zaffalon',
                email: 'zaffalonvictor@gmail.com',
                password: '123456',
                password_confirmation: '123456'
            )

           @source_account = Account.create(
               amount: 80000,
               name: 'Rodrigo Peixoto LTDA'
           ) 

           @destination_account = Account.create(
               amount: 40000,
               name: 'Victor Zaffalon LTDA',
               user_id: @user.id,
           )
        end

        context ".generate_account_transactions" do
            before do
                @account_transfer = AccountTransfer.create(
                    amount: 40000,
                    source_acount_id: @source_account.id,
                    destination_account_id: @destination_account.id,
                )
            end

            it 'should create transaction' do
                expect(AccountTransactions.all.length).to eq(4)
            end

            it 'should debit source account' do
                expect(@source_account.available_amount).to eq(@source_account.amount - @account_transfer.amount)
            end

            it 'should credit destination account' do
                expect(@destination_account.available_amount).to eq(@destination_account.amount + @account_transfer.amount)
            end
        end
        
    end
    
end