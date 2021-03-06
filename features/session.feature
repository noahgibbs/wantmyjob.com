Feature: Session handling
  In order to use the site
  As a registered user
  I need to be able to login and logout

  Background:
    Given that a confirmed user exists

  Scenario Outline: Logging in
    Given I am on the login page
    When I fill in "user_email" with "<email>"
    And I fill in "user_password" with "<password>"
    And I press "Sign in"
    Then I should <action>
    Examples:
      |         email       |  password   |              action             |
      | bad@example.com     |  password   | see "Invalid email or password" |
      | minimal@example.com |  test1234   | see "Signed in successfully"    |

  Scenario: Logging out
    Given I am logged in
    When I go to the sign out link
    Then I should see "Signed out successfully"
