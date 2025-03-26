package steps;

import io.cucumber.java.en.*;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;

import static org.junit.Assert.*;

public class basketStepDefs {

    WebDriver driver;

    @Given("I open the browser {string}")
    public void i_open_the_browser(String browser) {
        if (browser.equalsIgnoreCase("chrome")) {
            WebDriverManager.chromedriver().setup();
            driver = new ChromeDriver();
        } else if (browser.equalsIgnoreCase("firefox")) {
            WebDriverManager.firefoxdriver().setup();
            driver = new FirefoxDriver();
        } else {
            throw new RuntimeException("Unsupported browser: " + browser);
        }
        driver.manage().window().maximize();
    }

    @And("I navigate to {string}")
    public void i_navigate_to(String url) {
        driver.get(url);
    }

    @When("I enter my date of birth")
    public void i_enter_my_date_of_birth() {
        WebElement birthInput = waitForElement(By.cssSelector("#dp"));
        birthInput.clear();
        birthInput.sendKeys("17/12/1995");
    }

    @And("I register with name {string} {string}, email {string}, password {string}")
    public void i_register_with_basic_info(String firstName, String lastName, String email, String password) {
        waitForElement(By.id("member_firstname")).sendKeys(firstName);
        waitForElement(By.id("member_lastname")).sendKeys(lastName);
        waitForElement(By.id("member_emailaddress")).sendKeys(email);
        waitForElement(By.id("member_confirmemailaddress")).sendKeys(email);
        waitForElement(By.id("signupunlicenced_password")).sendKeys(password);
        waitForElement(By.id("signupunlicenced_confirmpassword")).sendKeys(password);
    }

    @And("I manually change the confirm password to {string}")
    public void i_manually_change_confirm_password(String confirmPassword) {
        WebElement confirmField = waitForElement(By.id("signupunlicenced_confirmpassword"));
        confirmField.clear();
        confirmField.sendKeys(confirmPassword);
    }

    @And("I agree to the terms and conditions")
    public void i_agree_terms() {
        WebElement checkbox = driver.findElement(By.cssSelector("#sign_up_25"));
        if (!checkbox.isSelected()) {
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", checkbox);
        }
    }

    @And("I agree to be over age 18")
    public void i_agree_over18() {
        WebElement checkbox = driver.findElement(By.cssSelector("#sign_up_26"));
        if (!checkbox.isSelected()) {
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", checkbox);
        }
    }

    @And("I agree to the code of ethics and conduct")
    public void i_agree_code_of_ethics() {
        WebElement checkbox = driver.findElement(By.cssSelector("#fanmembersignup_agreetocodeofethicsandconduct"));
        if (!checkbox.isSelected()) {
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", checkbox);
        }
    }

    @And("I submit the registration form")
    public void i_submit_form() {
        WebElement submit = waitForElement(By.name("join"));
        assertTrue("Submit button should be enabled", submit.isEnabled());
        submit.click();
    }

    @Then("I click the button with text {string}")
    public void i_click_button_with_text(String buttonText) {
        WebElement confirmButton = waitForElement(By.xpath("//button[contains(text(),'" + buttonText + "')]"));
        assertTrue("Button should be visible", confirmButton.isDisplayed());
        confirmButton.click();
        driver.quit();
    }

    @Then("I should see an error message saying {string}")
    public void i_should_see_error_message(String expectedMessage) {
        WebElement errorBox = waitForElement(By.className("field-validation-error"));
        String actualMessage = errorBox.getText().trim();
        assertEquals(expectedMessage, actualMessage);
        driver.quit();
    }

    // Utility: Wait for visible element
    private WebElement waitForElement(By locator) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        return wait.until(ExpectedConditions.visibilityOfElementLocated(locator));
    }
}
