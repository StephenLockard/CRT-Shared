*** Settings ***
Library    QForce
Resource                        ../Common/common.robot
Resource                        settings.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite

*** Variables ***
${invalid_email}                notanemail
${long_company_name}            This is a very long company name that exceeds the maximum allowed character limit for the company field in Salesforce lead object
${future_date}                  01/01/2050
${past_date}                    01/01/1900

*** Test Cases ***
Attempt to Create Lead with Invalid Email
    [Documentation]             Attempt to create a lead with an invalid email address
    [Tags]                      Lead                        Negative               Validation
    Appstate                    Home
    LaunchApp                   Sales
    ClickUntil                  Recently Viewed             Leads
    ClickText                   New
    Fill Invalid Lead Email
    Verify Email Error Message

Attempt to Create Lead without Company
    [Documentation]             Attempt to create a lead with a company name that exceeds the maximum character limit
    [Tags]                      Lead                        Negative               Validation
    Appstate                    Home
    LaunchApp                   Sales
    ClickUntil                  Recently Viewed             Leads
    ClickText                   New
    Fill Lead without Copmany
    Verify Company Error Message

Attempt to Create Lead without Lead Status
    [Documentation]             Attempt to create a lead with a future date
    [Tags]                      Lead                        Negative               Validation
    Appstate                    Home
    LaunchApp                   Sales
    ClickUntil                  Recently Viewed             Leads
    ClickText                   New
    Fill Lead without Lead Status
    Verify Lead Status Error Message


*** Keywords ***
Fill Invalid Lead Email
    UseModal                    On
    TypeText                    First Name                  John
    TypeText                    Last Name                   Doe
    TypeText                    Company                     Test Company
    TypeText                    Email                       ${invalid_email}
    ClickText                   Save                        partial_match=false
    UseModal                    Off

Verify Email Error Message
    VerifyText                  You have entered an invalid format.
    VerifyText                  We hit a snag.
    VerifyText                  Review the following fields


Fill Lead without Company
    UseModal                    On
    TypeText                    First Name                  John
    TypeText                    Last Name                   Doe
    ClickText                   Save                        partial_match=false
    UseModal                    Off

Verify Company Error Message
    VerifyText                  Complete this field.
    VerifyText                  We hit a snag.
    VerifyText                  Review the following fields

Fill Lead without Lead Status
    UseModal                    On
    TypeText                    First Name                  John
    TypeText                    Last Name                   Doe
    TypeText                    Company                     Test Company
    PickList                    Lead Status                 --None--
    ClickText                   Save                        partial_match=false
    UseModal                    Off

Verify Lead Status Error Message
    VerifyText                  Complete this field.
    VerifyText                  We hit a snag.
    VerifyText                  Review the following fields
