*** Test Cases ***
    
*** Settings ***
Library    QWeb
Library    DataDriver    reader_class=TestDataApi    name=mobileDeviceList.xlsx

Suite Setup       Open Browser        about:blank     Chrome
Suite Teardown    Close All Browsers
Test Template     Example Test

*** Test Case ***
Mobile Browser Test with ${device}

*** Keywords ***
Example Test
    [Arguments]    ${device}
    Close All Browsers
    OpenBrowser    http://google.com     chrome    emulation=${device}
    TypeText    Search    Copado Robotic Testing\n
    ClickText    https://www.copado.com

    #Accept Cookies
    ClickText    Accept
    ScrollTo     WATCH A DEMO
    VerifyText            Talk to Sales
    ClickText             Talk to Sales
    TypeText           First Name*                 Moby    
    TypeText           Last Name*                  Mobilerson
    TypeText           Business Email*             MobinTime@copado.com
    TypeText           Phone*                      1234567890
    TypeText           Company*                    Copado
    DropDown           Employee Size*              1-2,500
    TypeText           Job Title*                  Sales Engineer
    DropDown           Country                     Finland

  
