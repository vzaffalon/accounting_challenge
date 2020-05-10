require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "accounts_controller", type: :request do

    before do
        @user = User.create(
            name: 'Victor Zaffalon',
            email: 'zaffalonvictor@gmail.com',
            password: '123456',
            password_confirmation: '123456'
        )

        @user_token = UserToken.create(
          user_id: @user.id
        )
    end

    describe ".create" do

        it 'should have generated an account' do
            name = "Victor Zaffalon LTDA"
            amount = "80000"
            post "/accounts", params: { name: name, amount: amount},  headers: { "Authorization" => "Bearer #{@user_token.token}" }
            expect(Account.all.length).to eq(1)
            expect(JSON.parse(response.body)['name']).not_to eq(name)
            expect(JSON.parse(response.body)['account_transactions'][0]['amount']).to eq(amount)
        end

    end

    # describe ".index" do

    #     before do
    #         @account_1 = Account.create(
    #             amount: 80000,
    #             name: 'Victor Zaffalon LTDA',
    #             user_id: @user.id,
    #             number: '123456',
    #         )

    #         @account_2 = Account.create(
    #             amount: 120000,
    #             name: 'Teste Zaffalon LTDA',
    #             user_id: @user.id,
    #             number: '134135'
    #         )
            
    #     end


    #     it 'should return accounts list' do
    #         get "/accounts",  headers: { "Authorization" => "Bearer #{@user_token.token}" }
    #         expect(JSON.parse(response.body).length).to eq(2)
    #         expect(JSON.parse(response.body)[0]['amount']).to eq(@account_1.amount)
    #     end
    # end

    # describe ".available_amount" do


    #     it 'should return available amount' do
    #         get "/accounts/" + @account.number,  headers: { "Authorization" => "Bearer #{@user_token.token}" }
    #         expect(JSON.parse(response.body)['available_amount']).to eq(@account.amount)
    #     end

    #     it 'should return no account' do
    #         inexistent_account_number = "99798"
    #         get "/accounts/" + inexistent_account_number,  headers: { "Authorization" => "Bearer #{@user_token.token}" }
    #         expect(JSON.parse(response.body)['error']).to eq('invalid account number')
    #     end
    
    # end
    
end