require 'spec_helper'

describe "booths/ballot_instructions.html.erb" do
  let(:booth) { mock_model(Booth, id: 13) }

  before do
    assign(:booth, booth)
    render
  end

  subject { rendered }

  it { should have_content('Instructions') }
  it { should have_button('Next') }
  it { should_not have_button('Previous') }
end
