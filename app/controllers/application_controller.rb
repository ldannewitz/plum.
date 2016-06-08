class ApplicationController < ActionController::API
  # include ActionController::Serialization
  # include ActionController::HttpAuthentication::Token::ControllerMethods
  # before_action :authenticate

  protected
    def authenticate_or_request
      authenticate_or_request_with_http_token do |token, options|
        User.find_by(auth_token: token)
      end
    end

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        User.find_by(auth_token: token)
      end
    end

    def render_unauthorized(realm=nil)
      if realm
        self.headers['WWW-Authenticate'] = %(Token realm="#{realm.gsub(/"/, "")}")
      end
      render json: 'Bad credentials', status: 401
    end
end
