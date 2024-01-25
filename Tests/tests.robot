*** Settings ***
Library                      DataDriver                reader_class=TestDataApi    name=Non_Apple_Devices.csv
Resource                     ../Common/common.robot
Resource                     settings.robot
Suite Setup                  Open Browser              about:blank                 chrome
Suite Teardown               Close All Browsers
Test Template    Mobile Browser Test






*** Test Cases ***
Mobile Browser Test with ${device}



*** Keywords ***
Mobile Browser Test
    [Arguments]              ${device}
    Close All Browsers
    OpenBrowser              http://google.com         chrome                      emulation=${device}
    GoTo                     https://copado.com

    #Accept Cookies
    ClickText                Accept
    ScrollTo                 WATCH A DEMO
    VerifyText               Talk to Sales
    ClickText                Talk to Sales

    TypeText                 First Name*               Marty
    TypeText                 Last Name*                McFly
    TypeText                 Business Email*           SavingTime@copado.com
    TypeText                 Phone*                    1234567890
    TypeText                 Company*                  Copado
    TypeText                 Job Title*                Sales Engineer
    DropDown                 Country                   Finland

    Login
    HoverText                Leads
    ClickText                Leads
    VerifyText               McFly, Marty
    ClickText                Mcfly, Marty
    VerifyText               Open - Not Contacted