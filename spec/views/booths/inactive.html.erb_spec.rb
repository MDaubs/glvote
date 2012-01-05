require 'spec_helper'

describe 'booths/inactive.html.erb' do
  let(:booth) { mock_model(Booth, state: mock(State, human_status: 'Human Status'), voter_name: 'Voter Name') }

  it "should display a please wait message" do
    assign(:booth, booth)
    render
    rendered.should have_content("Please wait")
  end
end
