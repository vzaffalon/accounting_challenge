require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "account_transfers_controller", type: :request do

    before do
        @user = FactoryBot.create(:user)

        @login_session = FactoryBot.create(:login_session)

        @source_account = FactoryBot.create(:account, amount: 80000)

        @destination_account = FactoryBot.create(:account, amount: 120000)
    end

    describe ".create" do

        it 'should have generated an account transfer' do
            transfer_amount = 40000
            post "/account_transfers", params: { amount: transfer_amount, source_account_id: @source_account.id, destination_account_id: @destination_account.id},  headers: { "Authorization" => "Bearer #{ @login_session.token}" }
            expect(AccountTransfer.all.length).to eq(1)
            expect(AccountTransaction.all.length).to eq(4)
            expect(JSON.parse(response.body)['source_account']['available_amount']).to eq(@source_account.amount - transfer_amount)
            expect(JSON.parse(response.body)['destination_account']['available_amount']).to eq(@destination_account.amount + transfer_amount)
        end

    end

    describe ".index" do
        before do
            @account_transfer = AccountTransfer.create(
                amount: 40000,
                source_account_id: @source_account.id,
                destination_account_id: @destination_account.id,
            )
        end
        it 'should return accounts transfers' do
            get "/account_transfers",  headers: { "Authorization" => "Bearer #{ @login_session.token}" }
            expect(JSON.parse(response.body).length).to eq(1)
            expect(JSON.parse(response.body)[0]['amount']).to eq( @account_transfer.amount)
        end
    end
    
end