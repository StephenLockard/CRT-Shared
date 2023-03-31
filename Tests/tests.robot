*** Settings ***
Documentation             Ensure that a mobile user can submit a request for a demo at https://copado.com
Resource                  ../Common/common.robot
Suite Setup               Open Browser              about:blank                 chrome
Suite Teardown            Close All Browsers






*** Test Cases ***
Mobile Browser Test with Samsung Galaxy S20 Ultra
    Close All Browsers
    OpenBrowser           http://google.com         chrome                      emulation=Samsung Galaxy S20 Ultra
    TypeText              Search                    Copado Robotic Testing\n
    ClickText             https://www.copado.com

    #Accept Cookies
    ClickText             Accept
    ScrollTo              WATCH A DEMO
    VerifyText            Talk to Sales
    ClickText             Talk to Sales

    TypeText              First Name*               Marty
    TypeText              Last Name*                McFly
    TypeText              Business Email*           SavingTime@copado.com
    TypeText              Phone*                    1234567890
    TypeText              Company*                  Copado
    DropDown              Employee Size*            1-2,500
    TypeText              Job Title*                Sales Engineer
    DropDown              Country                   Finland

    Login
    HoverText             Leads
    ClickText             Leads
    VerifyText            McFly, Marty
    ClickText             Mcfly, Marty
    VerifyText            Working - Contacted
Mobile Browser Test with Samsung Galaxy S8+
    Close All Browsers
    OpenBrowser           http://google.com         chrome                      emulation=Samsung Galaxy S8+
    TypeText              Search                    Copado Robotic Testing\n
    ClickText             https://www.copado.com

    #Accept Cookies
    ClickText             Accept
    ScrollTo              WATCH A DEMO
    VerifyText            Talk to Sales
    ClickText             Talk to Sales

    TypeText              First Name*               Marty
    TypeText              Last Name*                McFly
    TypeText              Business Email*           SavingTime@copado.com
    TypeText              Phone*                    1234567890
    TypeText              Company*                  Copado
    DropDown              Employee Size*            1-2,500
    TypeText              Job Title*                Sales Engineer
    DropDown              Country                   Finland

    Login
    HoverText             Leads
    ClickText             Leads
    VerifyText            McFly, Marty
    ClickText             Mcfly, Marty
    VerifyText            Working - Contacted
Mobile Browser Test with iPhone 12 Pro
    Close All Browsers
    OpenBrowser           http://google.com         chrome                      emulation=iPhone 12 Pro
    TypeText              Search                    Copado Robotic Testing\n
    ClickText             https://www.copado.com

    #Accept Cookies
    ClickText             Accept
    ScrollTo              WATCH A DEMO
    VerifyText            Talk to Sales
    ClickText             Talk to Sales

    TypeText              First Name*               Marty
    TypeText              Last Name*                McFly
    TypeText              Business Email*           SavingTime@copado.com
    TypeText              Phone*                    1234567890
    TypeText              Company*                  Copado
    DropDown              Employee Size*            1-2,500
    TypeText              Job Title*                Sales Engineer
    DropDown              Country                   Finland

    Login
    HoverText             Leads
    ClickText             Leads
    VerifyText            McFly, Marty
    ClickText             Mcfly, Marty
    VerifyText            Working - Contacted

Mobile Browser Test with iPhone SE
    Close All Browsers
    OpenBrowser           http://google.com         chrome                      emulation=iPhone SE
    TypeText              Search                    Copado Robotic Testing\n
    ClickText             https://www.copado.com

    #Accept Cookies
    ClickText             Accept
    ScrollTo              WATCH A DEMO
    VerifyText            Talk to Sales
    ClickText             Talk to Sales

    TypeText              First Name*               Marty
    TypeText              Last Name*                McFly
    TypeText              Business Email*           SavingTime@copado.com
    TypeText              Phone*                    1234567890
    TypeText              Company*                  Copado
    DropDown              Employee Size*            1-2,500
    TypeText              Job Title*                Sales Engineer
    DropDown              Country                   Finland

    Login
    HoverText             Leads
    ClickText             Leads
    VerifyText            McFly, Marty
    ClickText             Mcfly, Marty
    VerifyText            Working - Contacted

Mobile Browser Test with iPhone XR
    Close All Browsers
    OpenBrowser           http://google.com         chrome                      emulation=iPhone XR
    TypeText              Search                    Copado Robotic Testing\n
    ClickText             https://www.copado.com

    #Accept Cookies
    ClickText             Accept
    ScrollTo              WATCH A DEMO
    VerifyText            Talk to Sales
    ClickText             Talk to Sales

    TypeText              First Name*               Marty
    TypeText              Last Name*                McFly
    TypeText              Business Email*           SavingTime@copado.com
    TypeText              Phone*                    1234567890
    TypeText              Company*                  Copado
    DropDown              Employee Size*            1-2,500
    TypeText              Job Title*                Sales Engineer
    DropDown              Country                   Finland

    Login
    HoverText             Leads
    ClickText             Leads
    VerifyText            McFly, Marty
    ClickText             Mcfly, Marty
    VerifyText            Working - Contacted

Mobile Browser Test with iPad Air
    Close All Browsers
    OpenBrowser           http://google.com         chrome                      emulation=iPad Air
    TypeText              Search                    Copado Robotic Testing\n
    ClickText             https://www.copado.com

    #Accept Cookies
    ClickText             Accept
    ScrollTo              WATCH A DEMO
    VerifyText            Talk to Sales
    ClickText             Talk to Sales

    TypeText              First Name*               Marty
    TypeText              Last Name*                McFly
    TypeText              Business Email*           SavingTime@copado.com
    TypeText              Phone*                    1234567890
    TypeText              Company*                  Copado
    DropDown              Employee Size*            1-2,500
    TypeText              Job Title*                Sales Engineer
    DropDown              Country                   Finland

    Login
    HoverText             Leads
    ClickText             Leads
    VerifyText            McFly, Marty
    ClickText             Mcfly, Marty
    VerifyText            Working - Contacted
Mobile Browser Test with Pixel 5
    Close All Browsers
    OpenBrowser           http://google.com         chrome                      emulation=Pixel 5
    TypeText              Search                    Copado Robotic Testing\n
    ClickText             https://www.copado.com

    #Accept Cookies
    ClickText             Accept
    ScrollTo              WATCH A DEMO
    VerifyText            Talk to Sales
    ClickText             Talk to Sales

    TypeText              First Name*               Marty
    TypeText              Last Name*                McFly
    TypeText              Business Email*           SavingTime@copado.com
    TypeText              Phone*                    1234567890
    TypeText              Company*                  Copado
    DropDown              Employee Size*            1-2,500
    TypeText              Job Title*                Sales Engineer
    DropDown              Country                   Finland

    Login
    HoverText             Leads
    ClickText             Leads
    VerifyText            McFly, Marty
    ClickText             Mcfly, Marty
    VerifyText            Working - Contacted

    