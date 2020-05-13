require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "account_transactions_controller", type: :request do

    describe ".index" do
        before do
            @user = User.create(
                name: 'Victor Zaffalon',
                email: 'zaffalonvictor@gmail.com',
                password: '123456',
                password_confirmation: '123456'
            )
    
            @login_session = LoginSession.create(
              user_id: @user.id
            )
    
            @source_account = Account.create(
                amount: 80000,
                name: 'Rodrigo Peixoto LTDA',
                number: '123458',
                user_id: @user.id,
            ) 
 
            @destination_account = Account.create(
                amount: 40000,
                name: 'Victor Zaffalon LTDA',
                user_id: @user.id,
                number: '65443'
            )

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