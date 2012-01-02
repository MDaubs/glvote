class BoothsController < ApplicationController
  def show
    @booth = Booth.find(params[:id])
    render @booth.state
  end

  def update
    @booth = Booth.find(params[:id])
    @booth.update_attributes!(params[:booth])
    submit = params[:commit]
    if submit.present?
      submit = submit.gsub(' ','').underscore
      if @booth.respond_to?(submit)
        message = @booth.send(submit)
        if message.present?
          flash[:notice] = message
        end
      end
    end
    render @booth.state
  end
end
