*** Settings ***
Library                  QNow
Library                  RequestsLibrary

*** Variables ***
${incident_search}       //input[@class\="form-control" and @placeholder="Search"]

*** Keywords ***
Configuration
    SetConfig            HighlightColor              Orange
ServiceNow Login
    [Documentation]      Login to ServiceNow instance
    GoTo                 ${snowUrl}
    #Dropdown             language_select             en
    VerifyText           User name                   delay=2                     # wait until label is translated correctly
    TypeText             User name                   ${snowUser}
    TypeText             Password                    ${snowPass}
    ClickText            Log In

ServiceNow Home
    [Documentation]      Navigate to homepage, login if needed
    GoTo                 ${snowUrl}
    ${login_status} =    IsText                      Forgot Password             timeout=2
    Run Keyword If       ${login_status}             ServiceNow Login
    VerifyText           User menu

Delete Incident 
    [Documentation]      Adds user to ServiceNow via REST API
    [Arguments]          ${inc_id}
    ${auth}=             Create List                 ${snowUser}                 ${snowPass}
    ${headers}=          Create Dictionary           Content-Type=application/json                           Accept=application/json
    ${data}=             Create Dictionary           sysparm_query=number=${inc_id}                          sysparm_limit=1

    ${session}=          Create Session              incidents                   ${snowUrl}/api              auth=${auth}
    ${resp}=             Get On Session              incidents                   /now/table/incident         ${data}         headers=${headers}

    ${object}=           Evaluate                    json.loads("""${resp.content}""", strict=False)
    ${short_desc}=       Get From Dictionary         ${object["result"][0]}      short_description
    ${sys_id}=           Get From Dictionary         ${object["result"][0]}      sys_id
    Log                  Removing incident "${short_desc}"
    ${resp}=             Delete On Session           incidents                   /now/table/incident/${sys_id}