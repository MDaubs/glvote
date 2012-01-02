require 'spec_helper'

describe 'booths/inactive.html.erb' do
  let(:booth) { mock_model(Booth) }

  it "should display a please wait message" do
    assign(:booth, booth)
    render
    rendered.should have_content("Please wait")
  end
end
