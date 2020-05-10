require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "User", type: :model do

    describe "create" do

        before do
            @user = User.create(
                name: 'Victor Zaffalon',
                email: 'zaffalonvictor@gmail.com',
                password: '123456',
                password_confirmation: '123456'
            )
        end

        it 'should create user' do
            expect(User.all.length).to eq(1)
            expect(User.first.name).to eq(@user.name)
        end
    end
    
end