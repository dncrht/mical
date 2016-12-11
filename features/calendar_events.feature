@javascript
Feature: Manage the calendar events once I'm logged in
  Background:
    Given a logged in user

  Scenario: Create a new event
    Given there isn't an event for today
    And I visit the calendar
    And I click on today because I want to create an event
    And I add a description
    And I add a rating
    And I click on Save

    Then the calendar should reload
    And there must be an event for today

  Scenario: Edit existing event
    Given there's an event for today
    And I visit the calendar
    And I click on today because I want to modify an event
    And I add a description
    And I click on Save

    Then the calendar should reload
    And the event must have been updated

  Scenario: Cancel event edition
    Given there's an event for today
    And I visit the calendar
    And I click on today because I want to modify an event
    And I add a description
    And I click on Close

    Then the calendar should reload
    And the event must not have been updated

  Scenario: Delete existing event
    Given there's an event for today
    And I visit the calendar
    And I click on today because I want to modify an event
    And I click on Delete
    And I accept the confirm

    Then the calendar should reload
    And there must not be an event for today
