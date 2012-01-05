Feature: Poll Worker
  In order to ensure that only registered voters can cast a ballot
  As a poll worker
  I want to activate, deactivate, and monitor voting booths

  Scenario: I can activate a voting booth
    Given voting booth 1 is inactive
    When I login as a poll worker
    And  I see that voting booth 1 is "Inactive"
    And  I register "Gerald Filmore" for voting booth 1
    Then I see that voting booth 1 is "Ready For Voter"
    And  I see that "Gerald Filmore" is the active voter for voting booth 1

  Scenario: I can logout as a poll worker
    Given I login as a poll worker
    When  I logout as a poll worker
    Then  I cannot go to the poll worker screen

  Scenario: I can reset an active voting booth
    Given voting booth 1 is inactive
    And   I login as a poll worker
    And   I register "Gerald Filmore" for voting booth 1
    And   I see that voting booth 1 is "Ready For Voter"
    When  I reset voting booth 1
    Then  I see that voting booth 1 is "Inactive"

  @javascript
  Scenario: An inactive voting booth is immediately made ready when activated by a poll worker
    Given voting booth 1 is inactive
    And   I switch to the voting booth browser
    And   I use voting booth 1
    And   I switch to the poll worker's browser
    And   I login as a poll worker
    When  I register "Gerald Filmore" for voting booth 1
    And   I switch to the voting booth browser
    Then  I should see "Press begin"
