*** Settings ***
Resource                  ../Common/common.robot
Library                   QVision
Suite Setup               Setup Browser
Suite Teardown            End suite


*** Test Cases ***
Create CPQ Quote  
    Home 
    LaunchApp             Salesforce CPQ
    ClickText             Opportunities
    ClickText             Robotic Testing             delay=2
    ClickText             Create Quote

    UseModal
    VerifyText            Create Quote
    ${date}=              Get Current Date            result_format=%-d/%-m/%Y
    Set Suite Variable    ${date}
    TypeText              Quote Start Date            ${date}
    TypeText              Contract Length (months)    12
    ClickText             Next
    UseModal              Off

Edit CPQ Quote
    ${quoteID}=           GetText                     Q-
    Set Suite Variable    ${quoteID}
    ClickText             ${quoteID}
    ClickText             Show more actions
    ClickText             Edit Lines
    Sleep                 5
    SetConfig             ShadowDOM                   True

    ${startDate}=         GetInputValue               Start Date
    Should Be Equal       ${startDate}                ${date}

    ${subTerm}=           GetInputValue               Subscription Term
    Should Be Equal       ${subTerm}                  12

    ClickText             Add Products                anchor=Add Group
    VerifyText            Guided Selling
    DropDown              Cloud platform or individual product?                   Cloud Platform
    ClickText             Suggest
    ClickCheckbox         BigQuery                    On
    ClickText             Save                        anchor=Cancel

    ClickItem             Reconfigure Line            #engage icons with associative text
    ClickText             Cancel

    # UseFrame              //iframe                    # some CPQ tables are embedded in iFrames
    # VerifyTableCell       Net Unit Price              1                           120.000,00 USD
    ClickText             Save                        anchor=Cancel
    Sleep                 10

Preview & Validate PDF Document
    ClickText             Show more actions           timeout=60
    ClickText             Preview Document
    ClickText             Preview                     anchor=Cancel               delay=20
    Sleep                 45
    VerifyRow             Net 30                      row_text=slockard@copado.com
    VerifyRow             USD 120,000.00              row_text=TOTAL
    LogScreenshot

Submit and Approve Opportunity 
    ClickText             Opportunities
    ClickText             Robotic Testing             delay=2
    ClickText             ${quoteID}
    ClickText             Show more actions
    ClickText             Submit for Approval
    VerifyField           Approval Status             Approved

Delete CPQ Quote Data
    [tags]                Test data
    SetConfig             ShadowDOM                   False
    Home
    LaunchApp             Salesforce CPQ
    ClickText             Quotes
    VerifyText            ${quoteID}                  delay=3
    ClickText             ${quoteID}
    ClickText             Delete                      Clone
    ClickText             Delete                      Cancel

    ClickText             Opportunities               anchor=Accounts             delay=2
    ClickText             Robotic Testing                                         delay=2
    ClickText             Products                    partial_match=true          anchor=Related    delay=5

    ClickText             Google Cloud Platform       partial_match=false
    ClickText             Delete
    ClickText             Delete                      anchor=Cancel

    ClickText             BigQuery
    ClickText             Delete
    ClickText             Delete                      anchor=Cancel
    VerifyText            Opportunity Product "Robotic Testing BigQuery" was deleted

    ClickText             Opportunities
    ClickText             Robotic Testing
    VerifyNoText          ${quoteID}
    VerifyNoText          Google Cloud Platform
    VerifyNoText          BigQuery


