*** Settings ***
Resource                        ../Common/common.robot
Resource                        settings.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite

*** Test Cases ***
Test Case 1
    Set A
*** Keywords ***
Login and Launch App
    [Documentation]    Logs in to salesforce and launches the given application
    [Arguments]        ${appName}=Sales
    Login
    LaunchApp          Sales
Set A
    Login and Launch App