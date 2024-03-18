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
    

    ClickText    Show more actions    anchor=Book Appointment
    ClickText          Delete
    VerifyText         Are you sure you want to delete this account?
    ClickText          Delete                      2
    VerifyText         Undo
    VerifyNoText       Undo
    ClickText          Accounts                    partial_match=False

Cleanup                   
    Login
    Sleep              3
    LaunchApp          Sales
    ClickText          Accounts
    RunBlock           VerifyNoAccounts            timeout=180s             exp_handler=DeleteData
    Sleep              3