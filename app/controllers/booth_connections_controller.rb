class BoothConnectionsController < ApplicationController
  def create
    if logged_in? && session[:role] == ELECTION_WORKER
      booth_id = params[:booth_id].to_i
      session[:booth_id] = booth_id
      redirect_to booth_url(booth_id)
    else
      session[:booth_id] = nil
      redirect_to_login
    end
  end
end
