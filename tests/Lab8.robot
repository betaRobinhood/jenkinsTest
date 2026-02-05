*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://computing.kku.ac.th

*** Test Cases ***
Open KKU Computing Website (Headless Firefox)

    ${options}=    Evaluate    __import__('selenium.webdriver').webdriver.FirefoxOptions()
    Call Method    ${options}    add_argument    -headless

    Create Webdriver    Firefox    options=${options}
    Go To    ${URL}

    Wait Until Page Contains    Computing    timeout=10s

    Capture Page Screenshot
    Close Browser
