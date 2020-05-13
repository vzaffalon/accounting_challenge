require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "login_sessions_controller", type: :request do

    before do
        @user = FactoryBot.create(:user, email: 'zaffalonvictor@gmail.com')
    end


    describe ".create" do

        it 'should have generated an auth token' do
            post "/login_sessions", params: { email: 'zaffalonvictor@gmail.com', password: '123456'}
            expect(JSON.parse(response.body)['token']).not_to eq(nil)
            expect(LoginSession.all.length).to eq(1)
            expect(LoginSession.first.token).to eq(JSON.parse(response.body)['token'])
        end

        it 'should return invalid login' do
            post "/login_sessions", params: { email: 'zaffalonvictor@gmail.com', password: '12345678'}
            expect(JSON.parse(response.body)['message']).to eq('invalid_login')
            expect(LoginSession.all.length).to eq(0)
        end

    end
    
end