Feature: Poll Worker
  In order to ensure that only registered voters can cast a ballot
  As a poll worker
  I want to activate, deactivate, and monitor voting booths

  Background:
    Given voting booth 1 is inactive

  Scenario: I can activate a voting booth
    When I login as a poll worker
    And  I see that voting booth 1 is "Inactive"
    And  I register "Gerald Filmore" for voting booth 1
    Then I see that voting booth 1 is "Ready For Voter"
    And  I see that "Gerald Filmore" is the active voter for voting booth 1
