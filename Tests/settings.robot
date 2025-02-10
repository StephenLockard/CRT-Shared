*** Settings ***

*** Variables ***
${company}             ExampleCorp
${accountName}         ExamplaryBranch
${first}               Demo
${last}                McTest
${email}               DTest@test.test
${phone}               1234567890

${demoFirst}           Marty
${demoLast}            McFly

${protonPass}          CRTR0cks!

#This uses an XPath to target the Salesforce App Launcher.
#Whle we prefer not to use XPaths when possible, sometimes they are the best option.
${applauncher}         //*[contains(@class, "appLauncher")]

*** Keywords ***
Form Fill
    [Documentation]    This requests a demo
    TypeText           First Name*                 Marty
    TypeText           Last Name*                  McFly
    TypeText           Business Email*             delorean88@copado.com
    TypeText           Phone*                      1234567890
    TypeText           Company*                    Copado
    DropDown           Employee Size*              1-2,500
    TypeText           Job Title*                  Sales Engineer
    DropDown           Country                     United States


VerifyNoAccounts
    VerifyNoText       ${accountName}              timeout=3

DeleteData
    [Documentation]    RunBlock to remove all data until it doesn't exist anymore
    ClickText          ${accountName}


    ClickText          Show more actions           anchor=Book Appointment
    ClickText          Delete
    VerifyText         Are you sure you want to delete this account?
    ClickText          Delete                      2
    VerifyText         Undo
    VerifyNoText       Undo
    ClickText          Accounts                    partial_match=False

Cleanup                   
    Home
    Sleep              3
    LaunchApp          Sales
    ClickText          Accounts
    RunBlock           VerifyNoAccounts            timeout=180s                exp_handler=DeleteData
    Sleep              3

Verify New Lead Form
    UseModal           On
    VerifyText         New Lead

Fill Lead Information
    TypeText           First Name                  ${first}
    TypeText           Last Name                   ${last}
    TypeText           Company                     ${company}
    ClickText          Save                        partial_match=false
    VerifyText         ${first} ${last}
    UseModal           Off

Verify Lead Created
    VerifyText         ${first} ${last}
    VerifyText         ${company}

Attempt Incomplete Lead Save
    UseModal           On
    TypeText           First Name                  ${first}
    TypeText           Last Name                   ${last}
    ClickText          Save                        partial_match=false
    UseModal           Off

Verify Error Message
    VerifyText         We hit a snag.
    VerifyText         Review the following fields

Convert Lead
    ClickItem          Converted
    ClickText          Select Converted Status
    TypeText           Account Name                ${accountName}
    ClickText          Convert                     partial_match=false

Verify Conversion
    VerifyText         Your lead has been converted
    VerifyText         ${accountName}
    VerifyText         ${first} ${last}
    VerifyText         ${company}-
    ClickText          Go to Leads
    UseModal           Off

Verify Opportunity Details
    ClickText          Opportunities
    VerifyText         ${company}-
    ClickText          ${company}-
    ClickText          Details
    VerifyText         Leads
    VerifyText         TEST ROBOT                  anchor=2
    VerifyText         TEST ROBOT                  anchor=Stage
    VerifyField        Probability (%)             10%
    ScrollTo           Created By
    ClickText          Edit Description
    TypeText           Description                 Test automation helps us rapidly deliver high quality releases!
    ClickText          Save
    VerifyText         App Launcher