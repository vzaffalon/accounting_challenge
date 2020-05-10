require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "account_transfers_controller", type: :request do

    before do
        @user = User.create(
            name: 'Victor Zaffalon',
            email: 'zaffalonvictor@gmail.com',
            password: '123456',
            password_confirmation: '123456'
        )

        @user_token = UserToken.create(
            email: 'zaffalonvictor@gmail.com',
            password: 'password'
        )

        @source_account = Account.create(
            amount: 80000,
            name: 'Victor Zaffalon LTDA',
            user_id: @user.id,
        )

        @destination_account = Account.create(
            amount: 120000,
            name: 'Teste Zaffalon LTDA',
            user_id: @user.id,
        )
    end

    describe ".create" do

        it 'should have generated an account transfer' do
            transfer_amount = 40000
            post "/account_transfers", params: { amount: transfer_amount, source_acount_id: @source_account.id, destination_account_id: @destination_account.id},  headers: { "Authorization" => "Bearer #{@user_token.token}" }
            expect(AccountTransfer.all.length).to eq(1)
            expect(AccountTransaction.all.length).to eq(4)
            expect(JSON.parse(response.body)['source_account']['available_amount']).to eq(@source_account.amount - transfer_amount)
            expect(JSON.parse(response.body)['destination_account']['available_amount']).to eq(@destination_account.amount + transfer_amount)
        end

    end

    describe ".index" do

        it 'should return accounts transfers' do
            get "/accounts",  headers: { "Authorization" => "Bearer #{@user_token.token}" }
            expect(JSON.parse(response.body).length).to eq(2)
            expect(JSON.parse(response.body)[0]['available_amount']).to eq(@account.available_amount)
        end
    end
    
end