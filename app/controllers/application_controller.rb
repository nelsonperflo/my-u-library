class ApplicationController < ActionController::Base
  include SessionsHelper

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def librarian
      unless current_user.librarian?
        flash[:danger] = "You don't have permission to perform this action."
        redirect_to root_path
      end
    end

    def student
      unless current_user.student?
        flash[:danger] = "You don't have permission to perform this action."
        redirect_to root_path
      end
    end

end
