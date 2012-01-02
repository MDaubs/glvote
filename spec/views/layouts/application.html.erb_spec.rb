require 'spec_helper'

describe "layouts/application.html.erb" do
  it "displays flash notice" do
    flash[:notice] = 'A flash message'
    render
    rendered.should have_content('A flash message')
  end

  it "displays a voting booth number if a booth instance variable is available" do
    assign(:booth, mock_model(Booth, id: 12))
    render
    rendered.should have_content('Voting Booth #12')
  end
end
