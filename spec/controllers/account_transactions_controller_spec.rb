require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "account_transactions_controller", type: :request do

    describe ".index" do
        before do
            @user = FactoryBot.create(:user)
    
            @login_session = FactoryBot.create(:login_session)
    
            @source_account = FactoryBot.create(:account)
 
            @destination_account = FactoryBot.create(:account)

            @account_transfer = AccountTransfer.create(
                amount: 40000,
                source_account_id: @source_account.id,
                destination_account_id: @destination_account.id,
            )
        end
        it 'should return accounts transactions' do
            get "/account_transactions", params: { account_id: @source_account.id.to_s},  headers: { "Authorization" => "Bearer #{ @login_session.token}" }
            expect(JSON.parse(response.body).length).to eq(2)
            expect(JSON.parse(response.body)[1]['amount'].abs).to eq( @account_transfer.amount)
        end
    end
    
end