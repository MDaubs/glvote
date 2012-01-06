When /^(?!I am in)(.*(?= in)) in (.*) browser$/ do |step, browser|
  step "I am in #{browser} browser"
  step step
end

When /^I am in (.*) browser$/ do |browser|
  Capybara.session_name = browser
end

When /^I switch to (.*) browser$/ do |browser|
  Capybara.session_name = browser
end

Then /^I should see "([^"]*)"$/ do |content|
  sleep 5
  page.should have_content(content)
end
