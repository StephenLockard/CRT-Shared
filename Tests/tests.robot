*** Settings ***
Documentation           Ensure that a mobile user can submit a request for a demo at https://copado.com
Resource    ../Common/common.robot
Suite Setup             Open Browser                about:blank                 chrome
Suite Teardown          Close All Browsers






*** Test Cases ***
Mobile Browser Test with ${device}
    Close All Browsers
    OpenBrowser    http://google.com     chrome    emulation=${device}
    TypeText    Search    Copado Robotic Testing\n
    ClickText    https://www.copado.com

    #Accept Cookies
    ClickText    Accept
    ScrollTo     WATCH A DEMO
    VerifyText            Talk to Sales
    ClickText             Talk to Sales

    TypeText           First Name*                 Marty    
    TypeText           Last Name*                  McFly
    TypeText           Business Email*             SavingTime@copado.com
    TypeText           Phone*                      1234567890
    TypeText           Company*                    Copado
    DropDown           Employee Size*              1-2,500
    TypeText           Job Title*                  Sales Engineer
    DropDown           Country                     Finland
    
    Login
    HoverText          Leads
    ClickText          Leads
    VerifyText         McFly, Marty
    ClickText          Mcfly, Marty
    VerifyText         Working - Contacted
  
*** Variables ***    
${device}    Samsung Galaxy S20 Ultra