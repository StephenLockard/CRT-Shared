*** Settings ***
Library                QWeb
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite

*** Test Cases ***
Fresh Start
    Cleanup
Simple End To End Flow
    [Documentation]    This is an end to end test of a customer-facing lead generating form, and Salesforce.
    ...                We enter a lead from a website, log into Salesforce, and verify the lead and status.
    [Tags]             E2E                         Lead Generation

    GoTo               https://www.copado.com/robotic-testing
    ClickText          TALK TO SALES

    #Same button with class based and relative XPath
    # ClickElement     //*[contains(@class, "nav_btn w-button")]               #Gracious Comment
    # ClickElement     /html/body/div[2]/div/header/div[1]/div[2]/nav/ul/li[5]

    TypeText           First Name*                 Marty
    TypeText           Last Name*                  McFly
    TypeText           Business Email*             delorean88@copado.com
    TypeText           Phone*                      1234567890
    TypeText           Company*                    Copado
    DropDown           Employee Size*              1-2,500
    TypeText           Job Title*                  Sales Engineer
    DropDown           Country                     Netherlands
    Home
    LaunchApp          Sales
    ClickUntil         Send List Email                 Leads
    VerifyText         Marty McFly
    ClickText          Marty McFly
    ClickText          Details
    VerifyField        Name                        Mr. Marty McFly
    VerifyField        Company                     Copado
    VerifyText         No duplicate rules are activated. Activate duplicate rules to identify potential duplicate records.

Recorded Test
    [Documentation]    Here we turn on the recorder at the top of the editor, and demo how easy it is to use.    First, visit the copado website. Then, click the "GET A DEMO" button and fill out the form.    Finally, copy the recorded steps from the execution trace (bottom left panel) below
    [Tags]             E2E                         Lead Generation             Recorded
    GoTo               https://copado.com

Create a lead and account, convert a lead to an opportunity. 
    [Documentation]    This is an example of entering and converting a lead.
    [tags]             Lead                        TE-0000001

    #Verify we are home, and begin entering a new lead.
    Home
    LaunchApp          Sales
    ClickText          Leads
    ClickText          New

    #Fill out form and perform data validations by attempting to save an incomplete form.
    UseModal           On                          #The UseModal keyword allows us to easily target only the elements on the currently active modal, and not the entire DOM structure.
    VerifyText         New Lead
    Picklist           Salutation                  Mr.
    TypeText           First Name                  ${first}
    TypeText           Last Name                   ${last}
    ClickText          Save                        partial_match=false
    UseModal           Off                         #Turn off UseModal to interact with the error notification.
    VerifyText         We hit a snag.
    VerifyText         Review the following fields

    #Fill in remaining fields, save form
    UseModal           On
    TypeText           Company                     ${company}
    ClickText          Save                        partial_match=false
    VerifyText         Mr. Demo McTest
    UseModal           Off

    #Verify status updates function and select converted status
    ClickItem          Converted
    ClickText          Select Converted Status

    #Enter account name and convert lead
    TypeText           Account Name                ${accountName}
    ClickText          Convert                     partial_match=false
    VerifyText         Your lead has been converted
    VerifyText         ${accountName}
    VerifyText         ${first} ${last}
    VerifyText         ${company}-
    ClickText          Go to Leads
    UseModal           Off

    #Verify opportunity data is correct
    ClickText          Opportunities
    VerifyText         ${company}-
    ClickText          ${company}-
    ClickText          Details
    VerifyText         Leads
    VerifyText         TEST ROBOT                  anchor=2                    # We can use index anchors.
    VerifyText         TEST ROBOT                  anchor=Stage                # We can also use text based anchors.
    VerifyField        Probability (%)             10%
    ScrollTo           Created By
    ClickText          Edit Description
    TypeText           Description                 Test automation helps us rapidly deliver high quality releases!
    ClickText          Save
    VerifyText         App Launcher

    #Cleanup Data
    Home
    ClickText          Accounts
    RunBlock           VerifyNoAccounts            timeout=180s                exp_handler=DeleteData


Expected failure to demo self healing
    GoTo               https://www.copado.com/robotic-testing
    VerifyText         SPEAK TO SALES              timeout=1
