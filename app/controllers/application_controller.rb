class ApplicationController < ActionController::Base

    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    after_action  :store_location

    protected
    def after_sign_in_path_for(resource)
      #session[:previous_url] || events_path
      events_path
    end

    def configure_permitted_parameters
        # strong parametersを設定し、login_idを許可
        # devise_parameter_sanitizer.for(:sign_up){|u|
        #   u.permit(:login_id, :password, :password_confirmation)
        # }
        devise_parameter_sanitizer.permit(:sign_up){|u|
          u.permit(:login_id, :password, :name, :email, :password_confirmation)
        }
    
        # devise_parameter_sanitizer.for(:sign_in){|u|
        #   u.permit(:login_id, :password, :remember_me)
        # }
        devise_parameter_sanitizer.permit(:sign_in){|u|
          u.permit(:login_id, :password, :remember_me)
        }
    end

    def store_location
      if (request.fullpath != "/users/sign_in" && \
          request.fullpath != "/users/sign_up" && \
          request.fullpath != "/users/edit" && \
          !request.xhr?)
        session[:previous_url] = request.fullpath 
      end
    end
end
