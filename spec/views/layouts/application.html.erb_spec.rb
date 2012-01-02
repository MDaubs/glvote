require 'spec_helper'

describe "layouts/application.html.erb" do
  it "displays flash notice" do
    flash[:notice] = 'A flash message'
    render
    rendered.should have_content('A flash message')
  end
end
