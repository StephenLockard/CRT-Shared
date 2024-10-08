*** Settings ***
Resource    ../Common/common.robot
Resource    settings.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite

*** Variables ***
${invalid_email}      notanemail
${long_company_name}  This is a very long company name that exceeds the maximum allowed character limit for the company field in Salesforce lead object
${future_date}        01/01/2050
${past_date}          01/01/1900

*** Test Cases ***
Attempt to Create Lead with Invalid Email
    [Documentation]    Attempt to create a lead with an invalid email address
    [Tags]             Lead    Negative    Validation
    Appstate           Home
    LaunchApp          Sales
    ClickUntil         Recently Viewed    Leads
    ClickText          New
    Fill Invalid Lead Email
    Verify Email Error Message

Attempt to Create Lead with Excessively Long Company Name
    [Documentation]    Attempt to create a lead with a company name that exceeds the maximum character limit
    [Tags]             Lead    Negative    Validation
    Appstate           Home
    LaunchApp          Sales
    ClickUntil         Recently Viewed    Leads
    ClickText          New
    Fill Lead with Long Company Name
    Verify Company Name Error Message

Attempt to Create Lead with Future Date
    [Documentation]    Attempt to create a lead with a future date
    [Tags]             Lead    Negative    Validation
    Appstate           Home
    LaunchApp          Sales
    ClickUntil         Recently Viewed    Leads
    ClickText          New
    Fill Lead with Future Date
    Verify Date Error Message

Attempt to Convert Lead without Required Fields
    [Documentation]    Attempt to convert a lead without filling all required fields
    [Tags]             Lead    Conversion    Negative
    Appstate           Home
    LaunchApp          Sales
    ClickUntil         Recently Viewed    Leads
    ClickText          New
    Fill Minimal Lead Information
    Attempt Incomplete Lead Conversion
    Verify Conversion Error Message

Attempt to Convert Already Converted Lead
    [Documentation]    Attempt to convert a lead that has already been converted
    [Tags]             Lead    Conversion    Negative
    Appstate           Home
    LaunchApp          Sales
    ClickUntil         Recently Viewed    Leads
    Create and Convert Lead
    Attempt to Reconvert Lead
    Verify Already Converted Message

*** Keywords ***
Fill Invalid Lead Email
    UseModal           On
    TypeText           First Name    John
    TypeText           Last Name     Doe
    TypeText           Company       Test Company
    TypeText           Email         ${invalid_email}
    ClickText          Save          partial_match=false
    UseModal           Off

Verify Email Error Message
    VerifyText         Error
    VerifyText         Please enter a valid email address

Fill Lead with Long Company Name
    UseModal           On
    TypeText           First Name    John
    TypeText           Last Name     Doe
    TypeText           Company       ${long_company_name}
    ClickText          Save          partial_match=false
    UseModal           Off

Verify Company Name Error Message
    VerifyText         Error
    VerifyText         Company name is too long

Fill Lead with Future Date
    UseModal           On
    TypeText           First Name    John
    TypeText           Last Name     Doe
    TypeText           Company       Test Company
    TypeText           Birthdate     ${future_date}
    ClickText          Save          partial_match=false
    UseModal           Off

Verify Date Error Message
    VerifyText         Error
    VerifyText         Birthdate cannot be in the future

Fill Minimal Lead Information
    UseModal           On
    TypeText           First Name    John
    TypeText           Last Name     Doe
    TypeText           Company       Test Company
    ClickText          Save          partial_match=false
    UseModal           Off

Attempt Incomplete Lead Conversion
    ClickItem          Converted
    ClickText          Select Converted Status
    ClickText          Convert       partial_match=false

Verify Conversion Error Message
    VerifyText         Error
    VerifyText         Please fill in all required fields before converting the lead

Create and Convert Lead
    ClickText          New
    UseModal           On
    TypeText           First Name    John
    TypeText           Last Name     Doe
    TypeText           Company       Test Company
    ClickText          Save          partial_match=false
    UseModal           Off
    ClickItem          Converted
    ClickText          Select Converted Status
    TypeText           Account Name  Test Account
    ClickText          Convert       partial_match=false
    VerifyText         Your lead has been converted

Attempt to Reconvert Lead
    ClickText          Leads
    ClickText          John Doe
    ClickItem          Converted

Verify Already Converted Message
    VerifyText         This lead has already been converted
    VerifyText         You cannot convert a lead that has already been converted
