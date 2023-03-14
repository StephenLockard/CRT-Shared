*** Settings ***
*** Variables ***

*** Keywords ***
# Example of custom keyword with robot fw syntax
VerifyStage
    [Documentation]       Verifies that stage given in ${text} is at ${selected} state; either selected (true) or not selected (false)
    [Arguments]           ${text}                     ${selected}=true
    VerifyElement         //a[@title\="${text}"
nCino Login
    [Documentation]             Login to Salesforce instance
    GoTo                        ${nCinologinUrl}
    TypeText                    Username                    ${nCinoUsername}
    TypeText                    Password                    ${nCinoPassword}
    ClickText                   Log In
    