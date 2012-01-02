require 'spec_helper'

describe "home/index.html.erb" do
  let(:booths) { [stub_model(Booth, :id => 1), stub_model(Booth, :id => 2)] }

  before do
    assign(:booths, booths)
    render
  end

  subject { Capybara.string(rendered) }

  specify { subject.find('#booth_1').should have_button('Connect') }
  specify { subject.find('#booth_2').should have_button('Connect') }
end
