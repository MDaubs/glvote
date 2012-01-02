require 'spec_helper'

describe 'booths/ready.html.erb' do
  before do
    assign(:booth, mock_model(Booth, id: 24))
    render
  end

  it "prompts the voter to start boting" do
    rendered.should have_content('Press begin to start voting')
    rendered.should have_button('Begin')
    rendered.should have_selector("input[id=booth_begin_pressed][type=hidden][value=true]")
  end
end
