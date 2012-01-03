require 'spec_helper'

describe "home/_voter_registration.html.erb" do
  let(:registration) { mock_model(VoterRegistration, :booth_id => 12, :voter_name => 'Tom').as_new_record }

  before do
    assign(:registration, registration)
    render
  end

  subject { Capybara.string(rendered) }

  it { should have_selector('form#new_voter_registration') }
end
