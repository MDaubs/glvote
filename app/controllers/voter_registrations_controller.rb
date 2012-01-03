class VoterRegistrationsController < ApplicationController
  def create
    if logged_in?
      registration = VoterRegistration.new(params[:voter_registration])
      if registration.save
        redirect_to root_url
      else
        redirect_to root_url, notice: 'An error occurred registering the voter.'
      end
    else
      redirect_to_login
    end
  end
end
