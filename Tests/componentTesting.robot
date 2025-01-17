*** Settings ***
Library                         QForce
Resource                        ../Common/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite

*** Variables ***
${leadUrl}                     ${EMPTY}                  # Will store our lead URL

*** Test Cases ***
Test 1 Step A Only
    [Documentation]             Shows login and app launch
    Step A Login and Launch App

Test 2 Steps A,B
    [Documentation]             Shows creating a lead and storing URL
    Step A Login and Verify Dashboard
    Step B Create New Lead

Test 3 Steps B,C
    [Documentation]             Shows validation of created lead                        
    Step B Create New Lead
    Step C Validate Lead

Complete Regression Test Bed
    [Documentation]             Shows optimized flow of all steps
    [Tags]                      regression
    Step A Login and Launch App
    Step B Create New Lead
    Step C Validate Lead        ${leadUrl}

*** Keywords ***
Step A Login and Launch App
    [Documentation]             Login to Salesforce and launch Sales app
    Home
    LaunchApp                   Sales
    VerifyText                  Quarterly Performance

Step B Create New Lead
    [Documentation]             Create a new lead and store its URL
    Home
    LaunchApp                   Sales
    ClickText                   Leads
    ClickText                   New
    UseModal                    On
    TypeText                    Company                  Copado
    TypeText                    First Name                John
    TypeText                    Last Name                 Smith
    ClickText                   Save                      partial_match=false
    ${leadUrl}=                GetUrl
    Set Suite Variable          ${leadUrl}               # Make URL available to other test cases

Step C Validate Lead
    [Documentation]             Navigate to stored lead URL and verify details
    [Arguments]                 ${lead_Url}=https://slockard-dev-ed.lightning.force.com/lightning/r/Lead/00Q7Q00000FtYjdUAF/view
    Home
    GoTo                        ${lead_Url}
    ClickText                   Details
    VerifyField                 Company    Copado
