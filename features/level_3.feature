Feature: Manage addresses
  As an administrator
  I want to be able to manage customer address information
  So I can correct problems in addresses for my customers

  Background:
    Given an initial setup
  
  # READ METHODS
  Scenario: No active addresses yet
    Given no setup yet
    When I go to the addresses page
    Then I should see "There are no active addresses at this time."
    And I should not see "Recipient"
    And I should not see "Billing?"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"

  Scenario: View all addresses
    When I go to the addresses page
    Then I should see "Active Addresses"
    And I should see "Customer"
    And I should see "Recipient"
    And I should see "Address"
    And I should see "Billing?"
    And I should see "Anthony Corletti"
    And I should see "Alex Egan"
    And I should see "Jeff Egan"
    And I should see "5000 Forbes Avenue"
    And I should see "4000 Forbes Ave"
    And I should see "Pittsburgh, PA 15213"
    And I should see "Inactive Addresses"
    And I should not see "true"
    And I should not see "True"
    And I should not see "false"
    And I should not see "False"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"
  
  Scenario: The address customer name is a link to customer details
    When I go to the addresses page
    And I click on the link "Ryan Flood"
    And I should see "Phone"
    And I should see "Order History"
    And I should see "A Baking Factory customer since 2019"
        
  
  # CREATE METHODS
  # Scenario: Creating a new address is successful
  #   When I go to the new address page
  #   And I select "Corletti, Anthony" from "address_customer_id"
  #   And I fill in "address_recipient" with "Linda Corletti"
  #   And I fill in "address_street_1" with "10 Downing Street"
  #   And I fill in "address_street_2" with "Suite 134"
  #   And I fill in "address_city" with "Pittsburgh"
  #   And I select "Pennsylvania" from "address_state"
  #   And I fill in "address_zip" with "15237"
  #   And I press "Create Address"
  #   Then I should see "was added to the system"
  #   And I should see "Linda Corletti"
  #   And I should see "10 Downing Street"
  #   And I should see "Suite 134"
  #   And I should see "Pittsburgh, PA 15237"

  
  # Scenario: Creating a new address fails without a valid zip code
  #   When I go to the new address page
  #   And I select "Corletti, Anthony" from "address_customer_id"
  #   And I fill in "address_recipient" with "Linda Corletti"
  #   And I fill in "address_street_1" with "10 Downing Street"
  #   And I fill in "address_street_2" with "Suite 134"
  #   And I fill in "address_city" with "Pittsburgh"
  #   And I select "Pennsylvania" from "address_state"
  #   And I fill in "address_zip" with "5237"
  #   And I press "Create Address"
  #   Then I should see "should be five digits long"
  #   And I should not see "Pittsburgh, PA"

  
  
  # # UPDATE METHODS
  # Scenario: Updating an existing address is successful
  #   When I go to edit Melanie's address
  #   And I fill in "address_street_1" with "5001 Forbes"
  #   And I fill in "address_zip" with "15001"
  #   And I uncheck "address_is_billing"
  #   And I press "Update Address"
  #   Then I should see "was revised in the system"
  #   And I should see "5001 Forbes"
  #   And I should see "Pittsburgh, PA 15001"
  