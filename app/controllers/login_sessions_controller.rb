class LoginSessionsController < ApiController
    before_action :authenticate, only: :destroy

    def create
      if params[:email]
        users = User.where(email: params[:email])
        unless users.any?
          return render json: { message: 'invalid_login', code: 'invalid_login' }, status: :unprocessable_entity
        end

        user = users.first

        if user.authenticate(params[:password])
          login_session = LoginSession.create(
            user_id: user.id,
            expiry_at: Time.current + LoginSession::TTL,
          )

          render json: { token: login_session.token }
        else
          render json: { message: 'invalid_login', code: 'invalid_login' }, status: :unprocessable_entity
        end
      else
        render json: { message: 'invalid_login', code: 'invalid_login' }, status: :unprocessable_entity
      end
    end

    def destroy
      current_user_token.destroy
      @current_user.login_sessions.destroy_all if params[:all]
    end

    private

    def user_token_params
      params.permit(:email, :password)
    end
end
