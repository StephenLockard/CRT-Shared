*** Settings ***
Documentation           Ensure that a mobile user can submit a request for a demo at https://copado.com
Library                 QWeb
Suite Setup             Open Browser                about:blank                 chrome
Suite Teardown          Close All Browsers

*** Test Cases ***

Samsung Galaxy S20 Ultra
    Close All Browsers
    OpenBrowser    http://google.com     chrome    emulation=Samsung Galaxy S20 Ultra
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
    
iPhone SE
    Close All Browsers
    OpenBrowser    http://google.com     chrome    emulation=iPhone SE
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
iPhone XR
    
iPhone 12 Pro
Pixel 5   
Samsung Galaxy S8+
iPad Air
iPad Mini
Surface Pro 7
Surface Duo
Galaxy Fold
Samsung Galaxy A51/71
Nest Hub
Nest Hub Max
    
    
