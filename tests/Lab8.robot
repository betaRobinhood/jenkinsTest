*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://computing.kku.ac.th
${BROWSER}    Firefox

*** Test Cases ***
Open KKU Computing Website (Headless Firefox)
    [Documentation]    Open KKU Computing website using headless Firefox

    ${options}=    Evaluate    __import__('selenium.webdriver').webdriver.FirefoxOptions()
    Call Method    ${options}    add_argument    -headless

    Create Webdriver    ${BROWSER}    options=${options}
    Go To    ${URL}

    Wait Until Page Contains    Computing    timeout=10s

    Capture Page Screenshot
    Close Browser
