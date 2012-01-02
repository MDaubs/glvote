require 'spec_helper'

describe 'booths/voter_confirmation.html.erb' do
  before do
    assign(:booth, mock_model(Booth, id: 24, voter_name: 'Tom Smith'))
    render
  end

  it "prompts the voter to confirm their name" do
    rendered.should have_content('Is your name Tom Smith?')
    rendered.should have_button('Yes')
    rendered.should have_button('No')
  end
end
