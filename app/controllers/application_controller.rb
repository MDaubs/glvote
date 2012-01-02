class ApplicationController < ActionController::Base
  protect_from_forgery

  ELECTION_WORKER = 1

  def logged_in?
    session[:role].present?
  end

  def redirect_to_login
    session[:pre_auth_url] = request.fullpath
    redirect_to new_login_url
  end
end
