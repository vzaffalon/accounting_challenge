class UsersController < ApiController

    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user
      else
        render json: ErrorSerializer.serialize(@account), status: :unprocessable_entity
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
