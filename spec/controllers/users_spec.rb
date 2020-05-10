require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "user_controller", type: :request do

    describe ".create" do

        it 'should have a new user' do
            name = "Victor Zaffalon"
            post "/users", params: { name: name, email: 'zaffalonvictor@gmail.com', password: '123456', password_confirmation: '123456'}
            expect(User.all.length).to eq(1)
            expect(JSON.parse(response.body)['name']).to eq(name)
        end

    end
    
end