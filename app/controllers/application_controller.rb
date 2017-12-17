class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :logged_in_user

  private
    def logged_in_user
      unless logged_in? || controller_name == 'sessions'
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end
end
