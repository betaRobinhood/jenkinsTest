*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Open KKU Computing Website (Firefox)
    ${options}=    Evaluate    __import__('selenium.webdriver').webdriver.FirefoxOptions()
    Call Method    ${options}    add_argument    -headless

    Create Webdriver    Firefox    options=${options}
    Go To    https://computing.kku.ac.th

    Sleep    3s
    Close Browser
