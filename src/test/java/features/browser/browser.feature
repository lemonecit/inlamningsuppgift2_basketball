Feature: Register as new member on Basketball England
  Scenario Outline: Successful registration with valid data

#    Testing with hardcoded to check if everything is going well before using with outline
#    Given I open the browser "chrome"
#    And I navigate to "https://membership.basketballengland.co.uk/NewSupporterAccount"
#    When I enter my date of birth
#    And I register with name "Pierre" "Lemon", email "pierre.lemon@asasdsdasdasdasddle.com", password "abc123abc"
#    And I agree to the terms and conditions
#    And I agree to be over age 18
#    And I agree to the code of ethics and conduct
#    And I submit the registration form
#    Then I get access to membership page

    Given I open the browser "<browser>"
    And I navigate to "https://membership.basketballengland.co.uk/NewSupporterAccount"
    When I enter my date of birth
    And I register with name "<firstName>" "<lastName>", email "<email>", password "<password>"
    And I agree to the terms and conditions
    And I agree to be over age 18
    And I agree to the code of ethics and conduct
    And I submit the registration form
    Then I get access to membership page


#    Must be unique email address if you already have registred with this email before

    Examples:
      | browser | firstName | lastName | email                               | password  |
      | chrome  | Pierre    | Lemon    | pierre.lemo@wrwerasdsde.cse         | abc123ABC |
      | firefox | Ravit     | Yochay   | ravit.yochy@reewerdsasdasdasfple.sm | ry123ABC  |

  Scenario: Registration fails when last name is missing
    Given I open the browser "<browser>"
    And I navigate to "https://membership.basketballengland.co.uk/NewSupporterAccount"
    When I enter my date of birth
    And I register with name "Pierre" "", email "missing.laasdasdastname@example.com", password "abc123ABC"
    And I agree to the terms and conditions
    And I agree to be over age 18
    And I agree to the code of ethics and conduct
    And I submit the registration form
    Then I should see an error message that describes with text "Last Name is required"

    Examples:
      | browser |  |  |  |  |
      | chrome  |  |  |  |  |
      | firefox |  |  |  |  |

  Scenario: Registration fails when passwords do not match
    Given I open the browser "<browser>"
    And I navigate to "https://membership.basketballengland.co.uk/NewSupporterAccount"
    When I enter my date of birth
    And I register with name "Pierre" "Mismatch", email "mismatch@example.com", password "abc123ABC"
    And I manually change the confirm password to "WrongPASS123"
    And I agree to the terms and conditions
    And I agree to be over age 18
    And I agree to the code of ethics and conduct
    And I submit the registration form
    Then I should see an error message that describes with text "Password did not match"

    Examples:
      | browser |  |  |  |  |
      | chrome  |  |  |  |  |
      | firefox |  |  |  |  |

  Scenario: Registration fails when terms and conditions are not accepted
    Given I open the browser "<browser>"
    And I navigate to "https://membership.basketballengland.co.uk/NewSupporterAccount"
    When I enter my date of birth
    And I register with name "Pierre" "NoTerms", email "noterms@example.com", password "abc123ABC"
    And I agree to be over age 18
    And I agree to the code of ethics and conduct
    And I submit the registration form
    Then I should see an error message that describes with text "You must confirm that you have read and accepted our Terms and Conditions"

    Examples:
      | browser |  |  |  |  |
      | chrome  |  |  |  |  |
      | firefox |  |  |  |  |


