*** Settings ***
*** Variables ***
${oppUrl}                      https://slockard-dev-ed.lightning.force.com/lightning/r/Opportunity/0067Q00000QmD1IQAV/view
*** Keywords ***
# Example of custom keyword with robot fw syntax
VerifyStage
    [Documentation]    Verifies that the stage given in ${text} is at ${selected} state; either selected (true) or not selected (false).
    [Arguments]        ${text}    
    VerifyAttribute    ${text}    aria-selected    true    element_type=text
nCino Login
    [Documentation]             Login to Salesforce instance
    GoTo                        ${nCinologinUrl}
    TypeText                    Username                    ${nCinoUsername}
    TypeText                    Password                    ${nCinoPassword}
    ClickText                   Log In
    