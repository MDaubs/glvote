class HomeController < ApplicationController
  def index
    if logged_in?
      @booths = Booth.all
      @registration = VoterRegistration.new
    else
      redirect_to_login
    end
  end
end
