require 'spec_helper'

describe "booths/ballot_selection.html.erb" do
  let(:booth_without_selection) { mock_model(Booth,
                                             id: 10,
                                             active_selection: mock_model(BallotSelection, id: 20, ballot_id: 10, candidate_id: nil),
                                             active_office: mock_model(Office, name: 'Postmaster', candidates:
                                                                       [
                                                                         mock_model(Candidate, id: 30, name: 'Franklin'),
                                                                         mock_model(Candidate, id: 31, name: 'Hamilton')
                                                                       ])) }

  describe "without an existing selection" do
    before do
      assign(:booth, booth_without_selection)
      render
    end

    subject { rendered }

    it { should have_content('Postmaster') }
    it { should have_content('Franklin') }
    it { should have_selector("input[name='booth[active_selection][candidate_id]'][type=radio][value='30']") }
    it { should have_content('Hamilton') }
    it { should have_selector("input[name='booth[active_selection][candidate_id]'][type=radio][value='31']") }
    it { should have_button('Next') }
    it { should have_button('Previous') }
  end

  describe "with an existing selection" do
    before do
      #assign(:booth, booth_with_selection)
      render
    end

    subject { rendered }
  end
end
