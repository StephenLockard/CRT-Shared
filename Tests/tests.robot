*** Settings ***
Resource               ../Common/common.robot
Resource               settings.robot
Suite Setup            Setup Browser
Suite Teardown         End suite


*** Test Cases ***
Create New Relationship
    [Documentation]    In this test a new relationshop is created and verified
    [tags]             Relationship                Regression
    SetConfig                   DefaultTimeout              60s  
    nCino Login
    ClickText          Relationships
    Sleep              4
    ClickText          New
    VerifyText         New Relationship
    ClickText          Individual
    ClickText          Next
    UseModal
    VerifyText         New Relationship: Individual
    TypeText           Relationship Name           Robots, LLC
    PickList           Relationship Type           Limited Liability Company
    VerifyPickList     Status                      Prospect
    ClickCheckbox      Employee Relationship       on
    ClickText          Save                        partial_match=False

    VerifyField        Relationship Name           Robots, LLC
    VerifyField        Relationship Type           Limited Liability Company
    VerifyField        Status                      Prospect

Add Loan Product to New Relationship
    ClickText          Products & Services
    ClickText          NEW LOAN PRODUCT
    TypeText           New Loan Name               To the Moon
    DropDown           Borrower Type               Borrower
    DropDown           Product Line                Commercial
    DropDown           Product Type                Non-Real Estate
    DropDown           Product                     Line Of Credit              timeout=5
    ClickText          Create New Loan
    #Sleep              5
    #VerifyStage        Qualification

Edit and Verify Loan Information 
    ClickText          Loan Information
    DropDown           Loan Type                   Small business
    TypeText           Loan Amount                 1000000
    ClickText          Save
    VerifyText         Line of Credit - Commercial - Non-Real Estate
    VerifyText         Proposal                    anchor=Stage
    VerifyText         Open                        anchor=Status
    VerifyText         $1,000,000.00               anchor=Loan Amount
    ClickText          Mark Stage as Complete
    #Sleep              5
    #VerifyStage        Proposal

Data Cleanup 
    ClickText          Loans
    ClickText          To the Moon
    ClickText          Delete
    ClickText          Delete                      anchor=Cancel
    ClickText          Loans
    Sleep              2
    ClickText          Relationships               partial_match=false
    ClickText          Robots, LLC
    ClickText          Delete
    UseModal           On
    Sleep              4
    ClickText          Delete                      anchor=Cancel
    Sleep              4
    ClickText          Delete 
    UseModal           Off







