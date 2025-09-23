# language: en
Feature: Addition in Windows Calculator
  As a user
  I want to add two numbers
  So that I get the correct result

  Scenario: Add 1 + 2
    Given the Calculator is open
    When I press "1"
    And I press +
    And I press "2"
    And I press =
    Then the result should be 3
