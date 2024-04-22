*** Settings ***
Resource                    ../Common/common.robot
Resource                    settings.robot
Suite Setup                 Setup Browser
Suite Teardown              End suite

*** Test Cases ***
Change Timezone
    [tags]                  Settings
    Configuration
    ServiceNow Login
    ClickText               Settings
    DropDown                Time zone                   Europe/Paris
    VerifySelectedOption    Time zone                   Europe/Paris
    DropDown                Time zone                   Europe/Stockholm
    ClickText               Close

Create Incident
    [Documentation]         Creates a new incident from UI
    [tags]                  Incidents
    Appstate                ServiceNow Home
    # Navigate to Incidents
    ClickText               All applications
    TypeText                Filter navigator            Incidents
    ClickText               Incidents
    VerifyText              Number                      # just to verify that the Incidents view opens
    ClickText               New
    VerifyText              New record

    # Fill in few details and get the id for later use
    TypeText                Short description           I have a problem with my Mac. My mic is not working.
    Dropdown                Urgency                     2 - Medium
    VerifySelectedOption    State                       New                         # verify that the default status is new
    ${number}=              GetInputValue               Number
    Set Suite Variable      ${number}

    # Submit
    ClickText               Submit
    
    ModuleSearch     ${number}
    VerifyText       I have a problem with my Mac.
    LogScreenshot


Edit Incident
    [Documentation]         Modifies incident details from UI
    [tags]                  Incidents
    Appstate                ServiceNow Home
    # Navigate to Incidents
    ClickText               All applications
    TypeText                Filter navigator            Self-Service
    ClickText               Incidents
    VerifyText              Number                      # just to verify that the Incidents view opens

    TypeText                ${incident_search}          ${number}\n
    ClickText               ${number}
    VerifyText              Update                      # verify that view changes and correct buttons are available


    # Modify incident and mark it resolved
    TypeText                Additional comments         Please enable application(s) to use microphone from System Settings
    Dropdown                State                       Resolved
    ClickText               Update
    VerifyText              Incident ${number} has been resolved


Using Global Seach
    [tags]                  Search
    Appstate                ServiceNow Home
    QNow.GlobalSearch       Users
    VerifyText              results for Users           #Verify search results available
    # open one of the resulting articles
    ClickText               Forgot email password

    # verify form values
    VerifyInputValue        Number                      INC0000004
    VerifyInputValue        Caller                      Fred Luddy
    VerifySelectedOption    Category                    Inquiry / Help
    VerifySelectedOption    State                       Closed
    VerifySelectedOption    Impact                      1 - High
    VerifySelectedOption    Urgency                     1 - High
    VerifySelectedOption    Priority                    1 - Critical
    VerifyInputValue        Assignment group            Service Desk

    # move between tabs
    ClickText               Related Records
    ClickText               Child Incidents
    ClickText               Resolution Information      delay=5                     # intentionally wait a bit here before changing screen
    VerifySelectedOption    Resolution code             Solved (Work Around)
    ClickText               Notes
    ClickText               Back

    # Should be back in search results
    VerifyText              results for Users


Remove Incident by REST API
    [tags]                  Incidents                   REST API
    Appstate                ServiceNow Home
    Delete Incident         ${number}

    # Navigating to Incidents just to verify that incident does not exist anymore
    ClickText               All applications
    TypeText                Filter navigator            Incidents
    ClickText               Incidents
    VerifyText              Number                      # just to verify that the Incidents view opens

    ModuleSearch          ${number}
    VerifyText              No records to display
