*** Settings ***
Library                QWeb
Resource               ../Common/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite

*** Variables ***
${message}             A Copado Robot wrote this message!
${sampleApex}          System.Debug('${message}');

*** Test Cases ***
Update Remote Site Settings
    Login
    ClickText          Setup
    ClickText          Setup for current app       delay=2
    SwitchWindow       NEW
    TypeText           Quick Find                  Remote Site Settings        delay=2
    ClickText          Remote Site Settings        delay=6
    ${edit_success}=    Set Variable    False
    FOR    ${i}    IN RANGE    3
        ClickText       Edit                       anchor=AA_Example    delay=1
        ${edit_success}=    Run Keyword And Return Status    VerifyText    Remote Site Name    timeout=5
        Exit For Loop If    ${edit_success}
        Log    Edit context not opened, retrying...
    END

    Run Keyword If    not ${edit_success}    Fail    Failed to open edit context after 3 attempts
    
    TypeText           Remote Site Name            AA_Example
    TypeText           Remote Site URL             https://updatedexample.new
    ClickCheckbox      Disable Protocol Security                               on
    TypeText           Description                 This description has been updated by a robot!
    LogScreenshot
    ClickText          Cancel
Use developer console to Execute Anonymous Apex
    [Documentation]    This test case executes Apex code from the developer console
    ...                and verifies that the log accurately reflects our input.
    Home
    ClickText          Setup
    ClickText          Developer Console
    SwitchWindow       NEW
    VerifyText         Query Editor
    ClickText          Debug
    VerifyText         Open Execute Anonymous Window
    ClickText          Open Execute Anonymous Window
    TypeText           Enter Apex Code             ${sampleApex}
    ClickText          Open Log
    VerifyText         Execute                     anchor=Open Log
    ClickText          Execute                     anchor=Open Log
    VerifyText         Filter
    TypeText           Filter                      USER_DEBUG                  delay=2
    VerifyText         ${message}                  delay=3
    LogScreenshot
    CloseWindow

Update Session Settings
    Home
    ClickText          Setup
    ClickText          Setup for current app
    SwitchWindow       NEW
    Sleep              3
    TypeText           Quick Find                  session
    VerifyText         Session Settings
    ClickText          Session Settings
    Sleep              3
    ScrollTo           Set the session security and session expiration
    ClickCheckbox      Disable session timeout warning popup                   on
    ClickCheckbox      Enforce login IP ranges on every request                on
    ScrollTo           Lightning Login
    ClickCheckbox      Allow only for users with the Lightning Login User permission      on
    ScrollTo           Session Security Levels
    ClickText          Multi-Factor Authentication                             partial_match=false
    ClickElement       //*[@title\="Add"]
    LogScreenShot
    Clicktext          Cancel
    CloseWindow

Enable Einstein
    Home
    ClickText          Setup
    ClickText          Setup for current app
    SwitchWindow       NEW
    TypeText           Quick Find                  Einstein
    ClickText          Settings                    anchor=Einstein Discovery
    VerifyText         Enable Decision Optimization (Beta)
    ClickCheckbox      Enable Decision Optimization (Beta)EnabledDisabled      on
    VerifyText         Enabled
    ClickCheckbox      Enable Decision Optimization (Beta)EnabledDisabled      off
    VerifyText         Disabled


