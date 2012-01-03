require 'spec_helper'

describe "home/index.html.erb" do
  let(:booths) { [stub_model(Booth, :id => 1), stub_model(Booth, :id => 2)] }

  before do
    assign(:booths, booths)
    stub_template 'home/_voter_registration.html.erb' => '[voter_registration]'
    render
  end

  subject { Capybara.string(rendered) }

  specify { subject.find('#booth_1').should have_button('Connect') }
  specify { subject.find('#booth_2').should have_button('Connect') }

  it "should render the voter_registration partial" do
    rendered.should have_content('[voter_registration]')
  end
end
