When /^I login as a poll worker$/ do
  login_as_election_worker
end

When /^I see that voting booth (\d+) is "([^"]*)"$/ do |booth_id, human_status|
  page.find("tr#booth_#{booth_id} td span.human_status").should have_content(human_status)
end

When /^I register "([^"]*)" for voting booth (\d+)$/ do |voter_name, booth_id|
  within('#new_voter_registration') do
    fill_in 'Voter name', with: voter_name
    select "Voting Booth ##{booth_id}", from: 'Booth'
    click_on 'Register Voter'
  end
end

Then /^I see that "([^"]*)" is the active voter for voting booth (\d+)$/ do |voter_name, booth_id|
  page.find("tr#booth_#{booth_id} td span.voter_name").should have_content(voter_name)
end
