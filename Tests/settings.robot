*** Settings ***
Library                   RequestsLibrary

*** Variables ***
${api}                    https://slockard-dev-ed.my.salesforce.com/ 
${account_name}           Acme Inc

*** Keywords ***
Authenticate into Salesforce
    Create Session    sfauth    ${api}
    ${params}=        Create Dictionary    grant_type= password
    ...            client_id= ${consumer_key}
    ...            client_secret= ${consumer_secret}
    ...            username= ${username}
    ...            password= ${password}
    ${resp} =      Post On Session         sfauth    /services/oauth2/token    params=${params}
    Should Be Equal As Strings             ${resp.status_code}                 200
    Log                        ${resp.json()}
    [Return]                   ${resp.json()}
    ${pat}=        Get From Dictionary         ${resp.json()}    access_token 
    Set Suite Variable                        ${pat}

    
SF API Create Account Record
    [Documentation]       Create Account Record via API
    &{ext_api_headers}    Create Dictionary   Content-Type=application/json    Authorization=Bearer ${pat}
    Create Session        sfauth     ${api}
    &{data}=              Create Dictionary    Name=${account_name}
    ${resp}=              Post On Session    sfauth    
    ...                   /services/data/v55.0/sobjects/Account/
    ...                   headers=&{ext_api_headers}  timeout=10
    ...                   json=${data}
    Log                   ${resp.status_code}
    Log To Console        ${resp.json()}
    Log                   ${resp.json()}
    [Return]              ${resp.json()}

SF API SOQL Query Account Record
    [Documentation]       SOQL Query Account Data via API
    &{ext_api_headers}    Create Dictionary   Content-Type=application/json    Authorization=Bearer ${pat}
    Create Session        sfauth     ${api}
    ${resp}=              Get On Session    sfauth    
    ...                   /services/data/v55.0/sobjects/Account/${account_id}
    ...                   headers=&{ext_api_headers}  timeout=10
    Log                   ${resp.status_code}
    Log To Console        ${resp.json()}
    Log                   ${resp.json()}
    [Return]              ${resp.json()}