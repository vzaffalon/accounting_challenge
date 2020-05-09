class AccountsTransferController < ApplicationController
    before_action :authenticate

    def create
      @account_transfer = AccountTransfer.new(account_transfer_params)
      if @account_transfer.save
        render json: @account_transfer
      else
        render json: ErrorSerializer.serialize(@account_transfer), status: :unprocessable_entity
      end      
    end

    def account_transfer_params
        params.permit(:amount,
                      :source_account_id,
                      :destination_account_id,
        )
    end
end
