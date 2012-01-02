require 'spec_helper'

describe "booths/ballot_confirmation.html.erb" do
  let(:booth) { mock_model(Booth, id: 13) }

  before do
    assign(:booth, booth)
    render
  end

  subject { rendered }

  it { should have_content('Confirmation') }
  it { should have_content('You are about to cast your ballot.') }
  it { should have_button('Cast Ballot') }
  it { should have_button('Previous') }
end
