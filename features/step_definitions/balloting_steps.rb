Given /^"([^"]*)" is running for "([^"]*)"$/ do |candidate_name, office_name|
  candidate(candidate_name, office(office_name))
end

Given /^voting booth (\d+) is assigned to "([^"]*)"$/ do |booth_id, voter_name|
  booth(booth_id).activate!(voter_name)
end

When /^I use voting booth (\d+)$/ do |booth_id|
  login_and_start_booth(booth_id)
end

When /^I start voting$/ do
  start_voting_at_booth
end

When /^I acknowledge that my name is "([^"]*)"$/ do |voter_name|
  acknowledge_voter_name(voter_name)
end

When /^I acknowledge the instructions$/ do
  acknowledge_ballot_instructions
end

When /^I select "([^"]*)" for "([^"]*)"$/ do |candidate_name, office_name|
  select_and_next_candidate(candidate_name, office_name)
end

When /^I cast my ballot$/ do
  confirm_to_cast_ballot
end

Then /^I see an indication that my ballot was cast$/ do
  page.should have_content('Your ballot has been cast.')
end

Then /^"([^"]*)" has (\d+) vote([s]*)$/ do |candidate_name, vote_count, ignore|
  Candidate.find_by_name(candidate_name).ballot_selections.count
end

Then /^voting booth (\d+) is inactive$/ do |booth_id|
  booth(booth_id).state.should be_a(InactiveState)
end

When /^I go to the previous screen$/ do
  click_on 'Previous'
end

Then /^I see that I selected "([^"]*)" for "([^"]*)"$/ do |candidate_name, office_name|
  page.should have_content(office_name)
  page.find('label', :text => candidate_name).should have_selector('input[checked]')
end
