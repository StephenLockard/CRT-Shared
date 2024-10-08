*** Settings ***
Documentation           Nwise test suite
Library                 QWeb
Suite Setup             Open Browser    about:blank    chrome
Suite Teardown          Close All Browsers

*** Test Cases ***
Pairwise Test Generation
    [Tags]      testgen       numtests=50    nwise=2
    GoTo        https://copado.com
    ClickText                 Book a Demo
    TypeText    First Name    [Teo, Dean, Vasil, Larry, Gandalf]
    TypeText    Last Name     [Smith, House, The Great, Lopez]
    TypeText    Business Email         VALID_EMAIL_ADDRESS
    TypeText    Phone                  1-555-123-4567
    TypeText    Company                [Copado, Example Inc, AnotherCorp]
    TypeText    Job Title              [Lead Sales Engineer, Account Executive]
    Dropdown    Country                United States