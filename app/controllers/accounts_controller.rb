class AccountsController < ApiController
    before_action :authenticate

    def index
        @accounts = Account.where("user_id = ?", @current_user.id).all
        render json: @accounts, meta: { total: @accounts.count }
    end

    def show
        @account = Account.where("user_id = :current_user_id and number = :number", current_user_id: @current_user.id, number: params[:number]).first
        if @account
            render json: @account
        else
            render json: {error: 'invalid account number'}, status: :unprocessable_entity
        end
    end

    def create
      @account = Account.new(account_params)
      @account.user_id = @current_user.id
      if @account.save
        render json: @account
      else
        render json: @account.errors, status: :unprocessable_entity
      end      
    end

    def account_params
        params.permit(:name,
                      :amount,
                      :number
        )
    end
end
