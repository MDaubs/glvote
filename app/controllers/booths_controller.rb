class BoothsController < ApplicationController
  def show
    @booth = Booth.find(params[:id])
    render @booth.state.view_name
  end

  def update
    @booth = Booth.find(params[:id])
    @booth.update_attributes!(params[:booth])
    submit = params[:commit]
    # If a submit parameter was passed try to call it on our current state
    if submit.present?
      submit = submit.gsub(' ','').underscore.to_sym
      if @booth.state.respond_to?(submit)
        # If the method accepts an argument pass in self
        if @booth.state.method(submit).arity == 1
          @booth.state.send(submit, self)
        else
          @booth.state.send(submit)
        end
        @booth.save!
      end
    end
    # If the state didn't trigger any rendering then default to render the state's view_name
    if response_body.nil?
      render @booth.state.view_name
    end
  end
end
