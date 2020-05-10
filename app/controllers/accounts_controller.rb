class AccountsController < ApiController
    before_action :authenticate

    def index
        @accounts = Account.where("user_id = ?", @current_user.id).all
        render json: @accounts, meta: { total: @accounts.count }
    end

    def show
        @account = Account.where("user_id = :current_user_id and number = :number", current_user_id: @current_user.id, number: params[:account_number]).first
        if @account
            render json: @account
        else
            render json: {error: 'invalid account number'}, status: :unprocessable_entity
        end
    end

    def create
      @account = Accounts.new(account_params)
      if @account.save
        render json: @account
      else
        render json: ErrorSerializer.serialize(@account), status: :unprocessable_entity
      end      
    end

    def account_params
        params.permit(:name,
                      :amount,
                      :user_id,
        )
    end
end
