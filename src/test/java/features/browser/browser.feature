Feature: Register as new member on Basketball England

  Scenario Outline: Successful registration with valid data
    Given I open the browser "<browser>"
    And I navigate to "https://membership.basketballengland.co.uk/NewSupporterAccount"
    When I enter my date of birth
    And I register with name "<firstName>" "<lastName>", email "<email>", password "<password>"
    And I agree to the terms and conditions
    And I agree to be over age 18
    And I agree to the code of ethics and conduct
    And I submit the registration form
    Then I click the button with text "Confirm and Join"

    Examples:
      | browser | firstName | lastName | email                    | password  |
      | chrome  | Pierre    | Lemon    | pierre.lemon@example.com | abc123ABC |
      | firefox | Ravit     | Yochay   | ravit.yochay@example.com | ry123ABC  |

  Scenario: Registration fails when last name is missing
    Given I open the browser "chrome"
    And I navigate to "https://membership.basketballengland.co.uk/NewSupporterAccount"
    When I enter my date of birth
    And I register with name "Pierre" "", email "missing.lastname@example.com", password "abc123ABC"
    And I agree to the terms and conditions
    And I agree to be over age 18
    And I agree to the code of ethics and conduct
    And I submit the registration form
    Then I should see an error message saying "Last name is required"

  Scenario: Registration fails when passwords do not match
    Given I open the browser "chrome"
    And I navigate to "https://membership.basketballengland.co.uk/NewSupporterAccount"
    When I enter my date of birth
    And I register with name "Pierre" "Mismatch", email "mismatch@example.com", password "abc123ABC"
    And I manually change the confirm password to "WrongPASS123"
    And I agree to the terms and conditions
    And I agree to be over age 18
    And I agree to the code of ethics and conduct
    And I submit the registration form
    Then I should see an error message saying "Passwords do not match"

  Scenario: Registration fails when terms and conditions are not accepted
    Given I open the browser "chrome"
    And I navigate to "https://membership.basketballengland.co.uk/NewSupporterAccount"
    When I enter my date of birth
    And I register with name "Pierre" "NoTerms", email "noterms@example.com", password "abc123ABC"
    And I agree to be over age 18
    And I agree to the code of ethics and conduct
    And I submit the registration form
    Then I should see an error message saying "You must accept the terms and conditions"
