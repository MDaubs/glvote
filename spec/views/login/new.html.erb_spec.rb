require 'spec_helper'

describe "login/new.html.erb" do
  it "prompts for a password" do
    render
    rendered.should have_field('Password')
    rendered.should have_button('Login')
  end
end
