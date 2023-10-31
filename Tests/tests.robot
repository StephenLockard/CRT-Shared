*** Settings ***
Resource                        ../Common/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite

*** Variables ***
${message}    A Copado Robot wrote this message!
${sampleApex}        System.Debug('${message}');

*** Test Cases ***
Update Remote Site Settings
    Login
    ClickText         Setup
    ClickText         Setup for current app
    SwitchWindow      NEW
    TypeText          Quick Find                  Remote Site Settings
    ClickText         Remote Site Settings
    ClickText         Edit                        anchor=AA_Example
    TypeText          Remote Site Name            BB_Example
    TypeText          Remote Site URL             https://updatedexample.new
    ClickCheckbox     Disable Protocol Security    on
    TypeText          Description                  This description has been updated by a robot!
    LogScreenshot
    ClickText    Cancel     
Use developer console to Execute Anonymous Apex
    [Documentation]    This test case executes Apex code from the developer console
    ...                and verifies that the log accurately reflects our input. 
    Home
    ClickText              Setup
    ClickText              Developer Console
    #Tell the robot that we are on a new browser window
    SwitchWindow           NEW
    VerifyText             Query Editor
    ClickText              Debug
    VerifyText             Open Execute Anonymous Window
    ClickText              Open Execute Anonymous Window
    TypeText               Enter Apex Code    ${sampleApex}
    ClickText              Open Log
    VerifyText             Execute            anchor=Open Log
    ClickText              Execute            anchor=Open Log
    VerifyText             Filter
    Sleep                  2
    TypeText               Filter             USER_DEBUG
    VerifyText             ${message}
    LogScreenshot          
    CloseWindow           