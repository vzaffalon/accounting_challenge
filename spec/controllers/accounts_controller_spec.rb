require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "accounts_controller", type: :request do

    before do
        @user = FactoryBot.create(
           :user
        )

        @login_session = FactoryBot.create(:login_session, user: @user)

        @account_1 = FactoryBot.create(
            :account,
            amount: 80000,
            user: @user
        )

        @account_2 = FactoryBot.create(
            :account,
            amount: 120000,
            user: @user
        )
    end

    describe ".create" do

        it 'should have generated an account' do
            name = "Victor Zaffalon LTDA"
            amount = 80000
            post "/accounts", params: { name: name, amount: amount, number: '1234189'},  headers: { "Authorization" => "Bearer #{@login_session.token}" }
            expect(Account.all.length).to eq(3)
            expect(JSON.parse(response.body)['name']).to eq(name)
            expect(JSON.parse(response.body)['account_transactions'][0]['amount']).to eq(amount)
        end

    end

    describe ".index" do

        it 'should return accounts list' do
            get "/accounts",  headers: { "Authorization" => "Bearer #{@login_session.token}" }
            expect(JSON.parse(response.body).length).to eq(2)
            expect(JSON.parse(response.body)[0]['amount'].to_i).to eq(@account_1.amount)
        end
    end

    describe ".available_amount" do

        it 'should return available amount' do
            get "/accounts/" + @account_1.number,  headers: { "Authorization" => "Bearer #{@login_session.token}" }
            expect(JSON.parse(response.body)['available_amount'].to_i).to eq(@account_1.amount)
        end

        it 'should return no account' do
            inexistent_account_number = "99798"
            get "/accounts/" + inexistent_account_number,  headers: { "Authorization" => "Bearer #{@login_session.token}" }
            expect(JSON.parse(response.body)['error']).to eq('invalid account number')
        end
    
    end
    
end