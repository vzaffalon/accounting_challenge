class AccountsController < ApplicationController
    before_action :authenticate

    def create
      @account = Accounts.new(account_params)
      if @account.save
        render json: @account
      else
        render json: ErrorSerializer.serialize(@account), status: :unprocessable_entity
      end      
    end


    def available_amount
        
    end

    def account_params
        params.permit(:name,
                      :amount,
                      :user_id,
        )
    end
end
