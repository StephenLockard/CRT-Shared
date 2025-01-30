*** Settings ***
Resource                  ../Common/common.robot
Resource                  settings.robot
Library                   QVision
Suite Setup               Setup Browser
Suite Teardown            End suite


*** Test Cases ***
Create CPQ Quote  
    #Navigate to home page, conditionally login, launch the CPQ app and load our opportunity.
    AppState              Home
    LaunchApp             Salesforce CPQ
    GoTo                  ${oppUrl}

    #Create a quote for the opportunity
    VerifyText            Create Quote
    ClickText             Create Quote
    UseModal              on
    VerifyText            Create Quote
    ${date}=              Get Current Date            result_format=%b %d, %Y
    Set Suite Variable    ${date}
    TypeText              Quote Start Date            ${date}    delay=3
    TypeText              Contract Length (months)    12
    ClickText             Next
    UseModal              Off

Edit CPQ Quote
    #Capture Quote Text from UI
    ${fullText}=          GetText                     Q-
    #Use RegExp to clean up value
    ${number}=            Get Regexp Matches          ${fullText}                 Q-(\\d+)                1
    ${quoteID}=           Set Variable                Q-${number}[0]
    Set Suite Variable    ${quoteID}
    ClickText             ${quoteID}

    #Verify quote details
    VerifyField           Quote Number                ${quoteID}
    VerifyField           Currency                    USD - U.S. Dollar
    VerifyFIeld           Type                        Quote
    VerifyField           Status                      Draft

    #Edit Quote
    ClickText             Show more actions
    ClickUntil            This quote has no line items.                           Edit Lines
    #This configuration enables Copado to handle ShadowDOM access automatically.
    SetConfig             ShadowDOM                   True

    #Capture and compare start date and subscription term
    ${startDate}=         GetInputValue               Start Date
    ${convertedDate}=     Convert Date                ${startDate}                date_format=%m/%d/%Y    result_format=%b %d, %Y
    Should Be Equal       ${convertedDate}            ${date}
    ${subTerm}=           GetInputValue               Subscription Term
    Should Be Equal       ${subTerm}                  12

    #Add products
    ClickText             Add Products                anchor=Add Group
    VerifyText            Guided Selling
    DropDown              Cloud platform or individual product?                   Cloud Platform
    ClickText             Suggest
    ClickCheckbox         BigQuery                    On
    ClickText             Save                        anchor=Cancel

    #Example of editing product lines
    ClickItem             Reconfigure Line            #engage icons with associative text
    ClickText             Cancel

    ClickUntil            Create New Product Request                              Save                    anchor=Cancel

Preview & Validate PDF Document
    #Open document preview
    VerifyField           Quote Number                ${quoteID}
    ClickText             Show more actions           timeout=60
    VerifyText            Preview Document
    HotKey                pagedown
    ClickUntil            Document Options            Preview Document
    VerifyText            Preview                     anchor=Cancel
    ClickText             Preview                     anchor=Cancel
    Sleep                 15
    VerifyRow             Net 30                      row_text=mkohler@copado.com
    VerifyRow             USD 120,000.00              row_text=TOTAL
    LogScreenshot

Submit and Approve Opportunity 
    GoTo                  ${oppUrl}
    ClickText             ${quoteID}
    VerifyField           Quote Number                ${quoteID}
    VerifyField           Currency                    USD - U.S. Dollar
    VerifyFIeld           Type                        Quote
    VerifyField           Status                      Draft
    ClickText             Show more actions
    VerifyText            Submit for Approval
    ClickText             Submit for Approval
    VerifyField           Approval Status             Approved


Delete CPQ Quote Data
    [tags]                Test data
    Home
    LaunchApp             Salesforce CPQ
    ClickText             Quotes
    VerifyText            ${quoteID}                  delay=3
    ClickText             ${quoteID}
    ClickText             Show more actions
    VerifyText            Delete
    ClickText             Delete
    VerifyText            Are you sure you want to delete this Quote?
    ClickText             Delete
    VerifyText            was deleted

    ClickText             Opportunities               anchor=Accounts             delay=2
    ClickText             Robotic Testing             delay=2
    ClickText             Products                    partial_match=true          anchor=Related          delay=2

    ClickText             Google Cloud Platform       partial_match=false
    VerifyText            Robotic Testing Google Cloud Platform
    ClickText             Delete
    VerifyText            Are you sure you want to delete this opportunity product?
    ClickText             Delete                      anchor=Cancel
    VerifyText            was deleted

    ClickText             BigQuery
    VerifyText            Robotic Testing BigQuery
    ClickText             Delete
    VerifyText            Are you sure you want to delete this opportunity product?
    ClickText             Delete                      anchor=Cancel
    VerifyText            was deleted

    GoTo                  ${oppUrl}
    ClickText             Details
    VerifyNoText          ${quoteID}
    VerifyNoText          Google Cloud Platform
    VerifyNoText          BigQuery


