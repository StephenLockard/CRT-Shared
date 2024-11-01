*** Settings ***
Resource                   ../Common/common.robot
Suite Setup                Setup Browser
Suite Teardown             End suite

*** Variables ***
${message}                 A Copado Robot wrote this message!
${sampleApex}              System.Debug('${message}');

*** Test Cases ***
Update Remote Site Settings
    [Tags]                 Deployment Automation
    Login
    GoTo                   ${login_url}lightning/setup/SetupOneHome/home
    TypeText               Quick Find                  Remote Site Settings        delay=2
    ClickText              Remote Site Settings        delay=6
    #Retry logic has been implemented, this will attempt to refresh the page three times.
    ${edit_success}=       Set Variable                False
    FOR                    ${i}                        IN RANGE                    3
        ClickText          Edit                        delay=10
        ${edit_success}=                               Run Keyword And Return Status                           VerifyText     Remote Site Name    timeout=5
        Exit For Loop If                               ${edit_success}
        RefreshPage
        Sleep              2
        Log                Edit context not opened, retrying...
    END
    #If we fail three times in a row, fail the test case and log an error
    Run Keyword If         not ${edit_success}         Fail                        Failed to open edit context after 3 attempts

    TypeText               Remote Site Name            AA_Example
    TypeText               Remote Site URL             https://updatedexample.new
    ClickCheckbox          Disable Protocol Security                               on
    TypeText               Description                 This description has been updated by a robot!
    LogScreenshot
    ClickText              Cancel
Use developer console to Execute Anonymous Apex
    [Tags]                 Deployment Automation
    [Documentation]        This test case executes Apex code from the developer console
    ...                    and verifies that the log accurately reflects our input.
    ...                    More complex apex scripts can be stored as a .apex file and called directly using
    ...                    the ExecuteApex keyword.
    Home
    ClickText              Setup
    ClickText              Developer Console
    SwitchWindow           NEW
    VerifyText             Query Editor
    ClickText              Debug
    VerifyText             Open Execute Anonymous Window
    ClickText              Open Execute Anonymous Window
    TypeText               Enter Apex Code             ${sampleApex}
    ClickText              Open Log
    VerifyText             Execute                     anchor=Open Log
    ClickText              Execute                     anchor=Open Log
    VerifyText             Filter
    TypeText               Filter                      USER_DEBUG                  delay=2
    VerifyText             ${message}                  delay=3
    LogScreenshot
    CloseWindow

Execute Apex from File
    Home
    Authenticate           ${consumer_key}             ${consumer_secret}          ${username}                 ${password}
    ${results}=            ExecuteApex                 ${CURDIR}/sampleApex.apex                               is_file=True

Update Session Settings
    [Tags]                 Deployment Automation
    Home
    GoTo                   ${login_url}lightning/setup/SetupOneHome/home
    TypeText               Quick Find                  session
    VerifyText             Session Settings
    ClickText              Session Settings
    Sleep                  3
    ScrollTo               Set the session security and session expiration
    ClickCheckbox          Disable session timeout warning popup                   on
    ClickCheckbox          Enforce login IP ranges on every request                on
    ScrollTo               Lightning Login
    ClickCheckbox          Allow only for users with the Lightning Login User permission                       on
    ScrollTo               Session Security Levels
    ClickText              Multi-Factor Authentication                             partial_match=false
    ClickElement           //*[@title\="Add"]
    LogScreenShot
    Clicktext              Cancel
    CloseWindow

Enable Einstein
    [Tags]                 Deployment Automation
    Home
    GoTo                   ${login_url}lightning/setup/SetupOneHome/home
    TypeText               Quick Find                  Einstein
    ClickText              Settings                    anchor=Einstein Discovery
    VerifyText             Enable Decision Optimization (Beta)
    ClickCheckbox          Enable Decision Optimization (Beta)EnabledDisabled      on
    VerifyText             Enabled
    ClickCheckbox          Enable Decision Optimization (Beta)EnabledDisabled      off
    VerifyText             Disabled


Disable Triggers
    [Tags]                 Deployment Automation
    Home
    GoTo                   ${login_url}lightning/setup/SetupOneHome/home
    TypeText               Quick Find                  Apex Triggers
    VerifyText             Apex Triggers
    ClickText              Apex Triggers
    VerifyText             This page allows you to view and modify all the triggers                            timeout=60
    VerifyText             AccountTriggerExample
    ClickText              AccountTriggerExample
    VerifyText             Apex Trigger Detail
    ClickText              Edit
    ClickCheckbox          is active                   on
    VerifyCheckboxValue    is active                   on
    ClickCheckbox          is active                   off
    VerifyCheckboxValue    is active                   off
    ClickText              Save





Disable Validation Rules
    [Tags]                 Deployment Automation
    Home
    GoTo                   ${login_url}lightning/setup/SetupOneHome/home
    TypeText               Quick Find                  Object Manager
    VerifyText             Object Manager
    ClickText              Object Manager
    VerifyText             Account
    ClickText              Account
    VerifyText             Validation Rules
    ClickText              Validation Rules
    VerifyText             Example_Validation
    ClickText              Example_Validation
    VerifyText             Account Validation Rule
    ClickText              Edit
    ClickCheckbox          Active                      on
    VerifyCheckboxValue    Active                      on
    ClickCheckbox          Active                      off
    VerifyCheckboxValue    Active                      off
    ClickText              Save

Disable Workflow Rules
    [Tags]                 Deployment Automation
    Home
    GoTo                   ${login_url}lightning/setup/SetupOneHome/home
    TypeText               Quick Find                  Workflow Rules
    VerifyText             Workflow Rules
    ClickText              Workflow Rules
    VerifyText             All Workflow Rules
    VerifyText             Deactivate                  anchor=Mark Early Job Completion as Failed
    ClickText              Deactivate                  anchor=Mark Early Job Completion as Failed
    VerifyText             Activate                    anchor=Mark Early Job Completion as Failed
    ClickText              Activate                    anchor=Mark Early Job Completion as Failed

Process Builder Flow
    [Tags]                 Deployment Automation
    Home
    GoTo                   ${login_url}lightning/setup/SetupOneHome/home
    TypeText               Quick Find                  Process Builder
    VerifyText             Process Builder
    ClickText              Process Builder
    VerifyText             My Processes
    ClickText              User Story Commit outdates latest Validation
    ClickText              Show all versions           anchor=User Story Commit outdates latest Validation
    VerifyText             Deactivate                  anchor=Version 1: User Story Commit outdates latest
    ClickText              Deactivate                  anchor=Version 1: User Story Commit outdates latest
    VerifyText             Are you sure you want to deactivate this version?
    ClickText              Confirm
    ClickText              Show all versions           anchor=User Story Commit outdates latest Validation
    VerifyText             Activate                    anchor=Version 1: User Story Commit outdates latest
    ClickText              Activate                    anchor=Version 1: User Story Commit outdates latest
    VerifyText             Activating this process automatically deactivates any other active version.
    ClickText              Confirm


