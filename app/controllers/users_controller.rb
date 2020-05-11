class UsersController < ApiController

    def create
      @user_exists = User.where("email = :email", email: params[:email]).first
      if @user_exists
        render json: {error: 'email already exists'}, status: :unprocessable_entity
      else
        @user = User.new(user_params)
        if @user.save
          render json: @user
        else
          render json: ErrorSerializer.serialize(@account), status: :unprocessable_entity
        end      
      end
    end

    def user_params
        params.permit(:name,
                      :email,
                      :password,
                      :password_confirmation
        )
    end
end
