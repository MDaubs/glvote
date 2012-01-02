def office(name)
  Office.find_or_create_by_name(name)
end

def candidate(name, office)
  office.candidates.find_or_create_by_name(name)
end

def booth(id)
  Booth.find_or_create_by_id(id)
end

def login_and_start_booth(id)
  login_as_election_worker
  within("#booth_#{id}") do
    click_on 'Connect'
  end
end

def login_as_election_worker
  visit root_url
  fill_in 'Password', with: Rails.configuration.election_worker_password
  click_on 'Login'
end

def start_voting_at_booth
  page.should have_content('Press begin to start voting')
  click_on 'Begin'
end

def acknowledge_voter_name(voter_name)
  page.should have_content(voter_name)
  click_on 'Yes'
end

def acknowledge_ballot_instructions
  page.should have_content('Instructions')
  click_on 'Next'
end

def select_and_next_candidate(candidate_name, office_name)
  page.should have_content(candidate_name)
  page.choose candidate_name
  click_on 'Next'
end

def confirm_to_cast_ballot
  page.should have_content('You are about to cast your ballot.')
  click_on 'Cast Ballot'
end
