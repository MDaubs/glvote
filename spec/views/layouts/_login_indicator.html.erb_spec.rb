require 'spec_helper'

describe "layouts/_login_indicator.html.erb" do
  it "displays a logout button when logged in" do
    view.stub(:logged_in?).and_return(true)
    render
    rendered.should have_button('Logout')
  end

  it "does nothing when logged out" do
    view.stub(:logged_in?).and_return(false)
    render
    rendered.should_not have_button('Logout')
  end
end
