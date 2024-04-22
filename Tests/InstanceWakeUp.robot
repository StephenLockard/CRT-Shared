*** Settings ***
Documentation          Wakes up the ServiceNOW developer environment
Library                QWeb
Suite Setup            Open Browser                about:blank     chrome
Suite Teardown         Close All Browsers

*** Test Cases ***
Wake up - login to developer site
    [Documentation]    Wakes up SN test instance by logging into SN Developer site
    SetConfig          ShadowDOM                   True            # Shadow DOM support
    GoTo               https://developer.servicenow.com/
    ClickText          Sign In
    TypeText           Email                       ${snowUser}
    ClickText          Next
    TypeSecret         Password                    ${snowPass}     delay=2
    ClickText          Sign In
    VerifyText         Welcome to ServiceNow!      delay=60        # waiting 1 min for instance to start waking up

    #Check to see if developer instance is available
    RunBlock           Check Instance              timeout=600s    exp_handler=CloseWindow
    LogScreenshot
    SwitchWindow       1
    LogScreenshot

*** Keywords ***
Check Instance
    [Documentation]    Opens a new window and verifies developer instance login is accessible.
    OpenWindow
    SwitchWindow       NEW
    GoTo               https://dev79016.service-now.com
    VerifyText         User name
    VerifyText         Log in