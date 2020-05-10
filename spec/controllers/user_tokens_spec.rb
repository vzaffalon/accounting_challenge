require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "user_tokens_controller", type: :request do

    before do
        @user = User.create(
            name: 'Victor Zaffalon',
            email: 'zaffalonvictor@gmail.com',
            password: '123456',
            password_confirmation: '123456'
        )
    end


    describe ".create" do

        it 'should have generated an auth token' do
            post "/user_tokens", params: { email: 'zaffalonvictor@gmail.com', password: '123456'}
            expect(JSON.parse(response.body)['token']).not_to eq(nil)
            expect(UserToken.all.length).to eq(1)
            expect(UserToken.first.token).to eq(JSON.parse(response.body)['token'])
        end

        it 'should return invalid login' do
            post "/user_tokens", params: { email: 'zaffalonvictor@gmail.com', password: '12345678'}
            expect(JSON.parse(response.body)['message']).to eq('invalid_login')
            expect(UserToken.all.length).to eq(0)
        end

    end
    
end