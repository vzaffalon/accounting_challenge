class ApiController < ActionController::API

    def api_key_from_header
        bearer_pattern = /^Bearer /
        auth_header = request.env['HTTP_AUTHORIZATION']

        return unless auth_header

        return auth_header.gsub(bearer_pattern, '') if auth_header.match(bearer_pattern)
    end

    def authenticate
        @current_user_token = LoginSession.find_by_token(api_key_from_header)

        if @current_user_token
            if @current_user_token.expiry_at && @current_user_token.expiry_at < Time.current
                @current_user_token.destroy
                render json: { message: 'This token has expired.', code: 'invalid_token' }, status: :unauthorized
                return false
            else
                @current_user_token.update_attributes(
                    expiry_at: @current_user_token.expiry_at ? Time.current + LoginSession::TTL : nil,
                )

                @current_user = @current_user_token.user
                unless @current_user
                    render json: { message: 'Invalid access token.', code: 'invalid_token' }, status: :unauthorized
                    return false
                end
            end
        else
            render json: { message: 'Invalid access token', code: 'invalid_token' }, status: :unauthorized
            return false
        end
    end

    private def current_user
        @current_user if defined?(@current_user)
    end

    private def current_user_token
        @current_user_token if defined?(@current_user_token)
    end
end