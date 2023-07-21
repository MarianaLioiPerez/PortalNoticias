class ApplicationController < ActionController::Base
        def after_sign_in_path_for(resource)
        root_path
        end

        def authorize_request(kind = nil)
            unless kind.include?(current_user.role)
            redirect_to root_path, notice: "You are not authorized to perform this action"
            end
        end
    end