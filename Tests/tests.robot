*** Settings ***
Resource                        ../Common/common.robot
Resource                        settings.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite

*** Test Cases ***
Fresh Start
    Cleanup
Simple End To End Flow
    [Documentation]   This is an end to end test of a customer-facing lead generating form, and Salesforce.     We enter a lead from a website, log into Salesforce, and verify the lead and status.
    [Tags]            E2E               Lead              Lead Generation
    GoTo              https://www.copado.com/robotic-testing
    VerifyText        Talk to Sales
    ClickText         Talk to Sales
    
    #This is an example of clicking the same element with a class or xpath based locator. 
    #ClickElement      //*[contains(@class,"secondary-btn w-button")]                       #Friendly comment
    #ClickElement      /html/body/section[1]/div/div/div[1]/div/div/a[3]
    
    TypeText          First Name*       Marty
    TypeText          Last Name*        McFly
    TypeText          Business Email*   delorean88@copado.com
    TypeText          Phone*            1234567890
    TypeText          Company*          Copado
    TypeText          Job Title*        Sales Engineer
    DropDown          Country           Netherlands
    Home
    LogScreenshot
    LaunchApp         Sales
    ClickUntil        Intelligence View     Leads
    VerifyText        Marty McFly
    ClickText         Marty McFly
    ClickText         Details
    VerifyField       Name              Mr. Marty McFly
    VerifyField       Company           Copado
    VerifyText        No duplicate rules are activated. Activate duplicate rules to identify potential duplicate records.

Recorder and Salesforce Guidance
    [Documentation]             Demo how easy it is to automate with the recorder by turning it on and creating a new lead in Salesforce.
    ...                         Next, delete the recorded automation, open the QWord Pallette to demonstrate filling in a new lead with Salesforce Guidance
    [Tags]                      E2E                         Lead Generation             Recorded                    Salesforce Guidance
    Home

Create a lead and account, convert a lead to an opportunity. 
    [Documentation]             This is an example of entering and converting a lead.
    [tags]                      Lead       Account    Opportunity                 

    #Verify we are home, and begin entering a new lead.
    Home
    LaunchApp                   Sales
    ClickUntil                  Recently Viewed                   Leads
    ClickText                   New

    #Verify data validation by attempting to save an incomplete form
    UseModal                    On                          #The UseModal keyword allows us to easily target only the elements on the currently active modal. 
    VerifyText                  New Lead
    
    TypeText                    First Name                  ${first}
    TypeText                    Last Name                   ${last}
    ClickText                   Save                        partial_match=false
    UseModal                    Off                         #Turn off UseModal to interact with the error notification.
    VerifyText                  We hit a snag.
    VerifyText                  Review the following fields

    #Fill in remaining fields, save form
    UseModal                    On
    TypeText                    Company                     ${company}
    ClickText                   Save                        partial_match=false
    VerifyText                  Demo McTest
    UseModal                    Off

    #Verify status updates function and select converted status
    ClickItem                   Converted
    ClickText                   Select Converted Status

    #Enter account name and convert lead
    TypeText                    Account Name                ${accountName}
    ClickText                   Convert                     partial_match=false
    VerifyText                  Your lead has been converted
    VerifyText                  ${accountName}
    VerifyText                  ${first} ${last}
    VerifyText                  ${company}-
    ClickText                   Go to Leads
    UseModal                    Off

    #Verify opportunity data is correct
    ClickText                   Opportunities
    VerifyText                  ${company}-
    ClickText                   ${company}-
    ClickText                   Details
    VerifyText                  Leads
    VerifyText                  TEST ROBOT                  anchor=2                    # We can use index anchors.
    VerifyText                  TEST ROBOT                  anchor=Stage                # We can also use text based anchors.
    VerifyField                 Probability (%)             10%
    ScrollTo                    Created By
    ClickText                   Edit Description
    TypeText                    Description                 Test automation helps us rapidly deliver high quality releases!
    ClickText                   Save
    VerifyText                  App Launcher

    #Cleanup Data
    Cleanup


Expected failure and Self Healing
    GoTo                        https://www.copado.com/robotic-testing
    LogScreenshot
    Run Keyword And Expect Error
    ...                         QWebElementNotFoundError: Unable to find element for locator SPEAK TO SALES in 1.0 sec
    ...                         VerifyText                  SPEAK TO SALES              timeout=1

    #To demonstrate Self Healing uncomment and run the line below.
    #VerifyText                 SPEAK TO SALES              timeout=5

Service Console E2E
    GoTo    https://account.proton.me/login
    VerifyText    Email or Username
    TypeText      Email or Username    slockardCopado@proton.me
    TypeText      Password             ${protonPass}
    ClickText     Sign in              delay=5
    ClickText     Proton Mail
    ClickText     New message
    TypeText      Email address        demoSupport@copado.com
    TypeText      Subject              Password reset
    TypeText      Sent with Proton Mail secure email    Please reset the password for my user, I forgot it and do not have access to recovery methods. 
    #Delete draft to prevent spam, in this demo we pretend that Email to Case is being triggered.
    ClickText     Delete draft
    VerifyText    Are you sure you want to permanently delete this draft?
    ClickText     Delete

    Home          
    
Create New Service Case with Recorder
    Home
    

