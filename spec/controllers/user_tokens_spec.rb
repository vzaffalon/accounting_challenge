require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "user_tokens_controller", type: :request do

    describe ".create" do

        it 'should have generated an auth token' do
            name = "Victor Zaffalon"
            post "/user_tokens", params: { email: 'zaffalonvictor@gmail.com', password: '123456'}
            expect(UserTokens.all.length).to eq(1)
            expect(JSON.parse(response.body)['token']).not_to eq(nil)
            expect(UserTokens.first.token).to eq(JSON.parse(response.body)['token'])
        end

    end
    
end