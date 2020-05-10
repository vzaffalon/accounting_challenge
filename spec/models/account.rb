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

           @destination_account_id = Account.create(
               amount: 40000,
               name: 'Victor Zaffalon LTDA'
           )
        end

        context ".generate_account_transactions" do
            before do
                @account_transfer = AccountTransfer.create(
                    amount: 40000,
                    source_acount_id: @source_account.id,
                    destination_account_id: @destination_account_id,
                )
            end

            it 'should create transaction' do
                expect(AccountTransactions.all.length).to eq(4)
            end
        end
        
    end
    
end