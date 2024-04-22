*** Settings ***
Library    QNow

*** Variables ***
${incident_search}          //input[@class\="form-control" and @placeholder="Search"]

*** Keywords ***
Login
    [Documentation]      Login to ServiceNow instance
    GoTo                 ${login_url}
    Dropdown             language_select              en
    VerifyText           User name                    delay=2   # wait until label is translated correctly
    TypeText             User name                    ${username}
    TypeText             Password                     ${password}
    ClickText            Log In