Feature: Manage customers
  As an administrator
  I want to be able to manage customer information
  So customers have accounts to use for making orders

  Background:
    Given an initial setup
  
  # READ METHODS
  Scenario: No active customers yet
    Given no setup yet
    When I go to the customers page
    Then I should see "No active customers at this time"
    And I should not see "Name"
    And I should not see "Phone"
    And I should not see "Email"
    And I should not see "Inactive Customers"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"

  Scenario: View all customers
    When I go to the customers page
    Then I should see "Active Customers"
    And I should see "Name"
    And I should see "Phone"
    And I should see "Email"
    And I should see "Corletti, Anthony"
    And I should see "Egan, Alex"
    And I should see "Flood, Ryan"
    And I should see "Freeman, Melanie"
    And I should see "alex.egan@example.com"
    And I should see "412-268-2323"
    And I should see "Inactive Customers"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"

  Scenario: View customer details
    When I go to Alex Egan details page
    Then I should see "A Baking Factory customer since 2018"
    And I should see "Alex Egan"
    And I should see "Phone"
    And I should see "412-268-8211"
    And I should see "Email"
    And I should see "alex.egan@example.com"
    And I should see "Order History"
    And I should see "Date"
    And I should see "Amount"
    And I should see "$22.50"
    And I should see "$5.25"
    And I should see "02/14/19"
    And I should not see "$16.50"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"
  
  Scenario: The customer name is a link to details
    When I go to the customers page
    And I click on the link "Egan, Alex"
    And I should see "Alex Egan"
    And I should see "Phone"
    And I should see "412-268-8211"
    And I should see "Order History"
    And I should see "Date"
    And I should see "Amount"
    And I should see "$5.25"
    And I should see "02/14/19"

  Scenario: The order date in #show is a link to order details
    When I go to Alex Egan details page
    And I click on the link "02/14/19"
    And I should see "Recipient"
    And I should see "Jeff Egan"
    And I should see "Thanks for being a Baking Factory customer since 2018."
    And I should see "Order History"
    And I should see "Date"
    And I should see "Amount"
    And I should see "$5.25"
    And I should see "02/14/19"
        
  
  # CREATE METHODS
  # Scenario: Creating a new customer is successful
  #   When I go to the new customer page
  #   And I fill in "customer_first_name" with "Ed"
  #   And I fill in "customer_last_name" with "Gruberman"
  #   And I fill in "customer_phone" with "(412) 268-3228"
  #   And I fill in "customer_email" with "gruberman@example.com"
  #   And I press "Create Customer"
  #   Then I should see "Ed Gruberman was added to the system"
  #   And I should see "Phone"
  #   And I should see "412-268-3228"
  #   And I should not see "Order History"
  #   And I should see "A Baking Factory customer since 2019"

  
  # Scenario: Creating a new customer fails without a valid email
  #   When I go to the new customer page
  #   And I fill in "customer_first_name" with "Ed"
  #   And I fill in "customer_last_name" with "Gruberman"
  #   And I fill in "customer_phone" with "(412) 268-3228"
  #   And I fill in "customer_email" with "gruberman@example,com"
  #   And I press "Create Customer"
  #   Then I should see "is not a valid format"
  #   And I should not see "412-268-3228"
  #   And I should not see "Order History"
  #   And I should not see "A Baking Factory customer since 2019"

  
  # Scenario: Creating a new customer fails without a phone
  #   When I go to the new customer page
  #   And I fill in "customer_first_name" with "Ed"
  #   And I fill in "customer_last_name" with "Gruberman"
  #   And I fill in "customer_email" with "gruberman@example.com"
  #   And I press "Create Customer"
  #   Then I should see "should be 10 digits"
  #   And I should not see "Order History"
  #   And I should not see "A Baking Factory customer since 2019"

  
  # # UPDATE METHODS
  # Scenario: Updating an existing customer is successful
  #   When I go to edit Melanie's record
  #   And I fill in "customer_email" with "melfree@cmu.edu"
  #   And I press "Update Customer"
  #   Then I should see "Melanie Freeman was revised in the system"
  #   And I should see "melfree@cmu.edu"
  #   And I should see "Order History"
  #   And I should see "$5.50"
  #   And I should see "A Baking Factory customer since 2019"

  
