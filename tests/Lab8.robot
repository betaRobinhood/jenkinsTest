*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Open Browser To Login Page
    ${chrome_options}=    Evaluate
    ...    __import__('selenium.webdriver').webdriver.ChromeOptions()

    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --headless

    Create Webdriver    Chrome    options=${chrome_options}
    Go To    https://computing.kku.ac.th


*** Test Cases ***
Open KKU Computing Website
    Open Browser To Login Page
    Sleep    3s
    Close Browser
