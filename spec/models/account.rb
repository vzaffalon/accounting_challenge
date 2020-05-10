require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "Account", type: :model do

    describe "create" do

        before do
            @user = User.create(
                name: 'Victor Zaffalon',
                email: 'zaffalonvictor@gmail.com',
                password: '123456',
                password_confirmation: '123456'
            )
        end

        context ".generate_first_transaction" do
            before do
                @account = Account.create(
                    amount: 80000,
                    name: 'Victor Zaffalon LTDA',
                    user_id: @user.id,
                ) 
               
            end

            it 'should have account start amount' do
                expect(AccountTransactions.all.length).to eq(1)
                expect(AccountTransactions.first.amount).to eq(@account.amount)
            end
        end
        
    end
    
end