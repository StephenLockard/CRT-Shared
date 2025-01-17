*** Settings ***
Library                         QForce
Resource                        ../Common/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite

*** Variables ***
${LEAD_URL}                     ${EMPTY}                  # Will store our lead URL

*** Test Cases ***
Test 1 Step A Only
    [Documentation]             Shows login and app launch
    Step A Login and Launch App

Test 2 Steps A,B
    [Documentation]             Shows creating a lead and storing URL
    Step A Login and Launch App
    Step B Create New Lead

Test 3 Steps B,C
    [Documentation]             Shows validation of created lead
    Step A Login and Launch App                           # Required setup
    Step B Create New Lead
    Step C Validate Lead

Complete Regression Test Bed
    [Documentation]             Shows optimized flow of all steps
    [Tags]                      regression
    Step A Login and Launch App
    Step B Create New Lead
    Step C Validate Lead

*** Keywords ***
Step A Login and Launch App
    [Documentation]             Login to Salesforce and launch Sales app
    Home
    LaunchApp                   Sales

Step B Create New Lead
    [Documentation]             Create a new lead and store its URL
    ClickText                   Leads
    ClickText                   New
    UseModal                    On
    TypeText                    *Company                  Copado Test
    TypeText                    First Name                John
    TypeText                    Last Name                 Smith
    ClickText                   Save
    ${LEAD_URL}=                GetUrl
    Set Suite Variable          ${LEAD_URL}               # Make URL available to other test cases

Step C Validate Lead
    [Documentation]             Navigate to stored lead URL and verify details
    GoTo                        ${LEAD_URL}
    VerifyText                  John Smith
    VerifyText                  Copado Test
