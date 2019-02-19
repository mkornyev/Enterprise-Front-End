Feature: Manage orders
  As an administrator
  I want to be able to order a standard package for a customer
  So make sure the core of my business runs correctly

  Background:
    Given an initial setup
  
  # READ METHODS
  Scenario: No orders yet
    Given no setup yet
    When I go to the orders page
    Then I should see "There are no orders at this time"
    And I should not see "Date"
    And I should not see "Recipient"
    And I should not see "Cost"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"

  Scenario: View all orders
    When I go to the orders page
    Then I should see "All Orders"
    And I should see "Date"
    And I should see "Customer"
    And I should see "Recipient"
    And I should see "Cost"
    And I should see "Anthony Corletti"
    And I should see "Jeff Egan"
    And I should see "02/17/19"
    And I should see "$22.50"
    And I should see "$16.50"
    And I should see "$5.25"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"

  Scenario: View order details
    When I go to the Valentine's Day order
    And I should see "Order Details"
    And I should see "Thanks for being a Baking Factory customer since 2018"
    And I should see "Recipient"
    And I should see "Jeff Egan"
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
  
  Scenario: The customer name is a link to customer details
    When I go to the orders page
    And I click on the link "Flood, Ryan"
    And I should see "Ryan Flood"
    And I should see "Phone"
    And I should see "Order History"
    And I should see "A Baking Factory customer since 2019"

  Scenario: The order date is a link to order details
    When I go to the orders page
    And I click on the link "02/14/19"
    And I should see "Order Details"
    And I should see "Thanks for being a Baking Factory customer since 2018"
    And I should see "Recipient"
    And I should see "Jeff Egan"
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

  
  # CREATE METHODS
  # Scenario: Creating a new order is successful
  #   When I go to the new order page
  #   And I select "Corletti, Anthony" from "order_customer_id"
  #   And I select "Ryan Flood : 5000 Forbes Avenue" from "order_address_id"
  #   And I fill in "order_grand_total" with "6.50"
  #   And I press "Create Order"
  #   Then I should see "Thank you for ordering from the Baking Factory."
  #   And I should see "Order Details"
  #   And I should see "Customer"
  #   And I should see "Corletti, Anthony"
  #   And I should see "Recipient"
  #   And I should see "Ryan Flood"
  #   And I should see "$6.50"

  
  # Scenario: Creating a new order fails without cost
  #   When I go to the new order page
  #   And I select "Corletti, Anthony" from "order_customer_id"
  #   And I select "Ryan Flood : 5000 Forbes Avenue" from "order_address_id"
  #   And I press "Create Order"
  #   Then I should not see "Thank you for ordering from the Baking Factory."
  #   And I should not see "Order Details"

  
