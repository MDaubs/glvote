Feature: Balloting
  In order to elect candidates to office
  As a registered voter
  I want to cast a ballot

  Background:
    Given "George Washington" is running for "President"
    And "John Adams" is running for "President"
    And "Alexander Hamilton" is running for "Treasury Secretary"
    And "Oliver Wolcott, Jr." is running for "Treasury Secretary"
    And voting booth 1 is assigned to "Tom Smith"

  Scenario: Casting a ballot increments votes
    When I use voting booth 1
    And  I start voting
    And  I acknowledge that my name is "Tom Smith"
    And  I acknowledge the instructions
    And  I select "George Washington" for "President"
    And  I select "Oliver Wolcott, Jr." for "Treasury Secretary"
    And  I cast my ballot
    Then I see an indication that my ballot was cast
    And  "George Washington" has 1 vote
    And  "John Adams" has 0 votes
    And  voting booth 1 is inactive

  Scenario: Voter sees previous steps and selections in reverse order
    When I use voting booth 1
    And  I start voting
    And  I acknowledge that my name is "Tom Smith"
    And  I acknowledge the instructions
    And  I select "George Washington" for "President"
    And  I select "Oliver Wolcott, Jr." for "Treasury Secretary"
    And  I go to the previous screen
    Then I see that I selected "Oliver Wolcott, Jr." for "Treasury Secretary"
    And  I go to the previous screen
    Then I see that I selected "George Washington" for "President"
    And  I go to the previous screen
    And  I acknowledge the instructions
    Then I see that I selected "George Washington" for "President"
