class LoginController < ApplicationController
  def new
  end

  def create
    if params[:login][:password] == Rails.configuration.election_worker_password
      session[:role] = ELECTION_WORKER
      redirect_to session[:pre_auth_url]
    else
      session[:role] = nil
      flash.now[:notice] = 'Unable to login, check that you have permission and the correct password.'
      render 'new'
    end
  end
end
