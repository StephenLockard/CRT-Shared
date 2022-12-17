*** Settings ***
Resource                        ../Common/common.robot
Resource                        settings.robot
Suite Setup                     Run Keywords
...                             Setup Browser
...                             Authenticate into Salesforce
Suite Teardown                  End suite

*** Test Cases ***

Authenticate QForce
    Authenticate     ${consumer_key}   ${consumer_secret}   ${username}    ${password}


Authenticate into Salesforce
    Create Session              sfauth                      ${api}
    ${params}=                  Create Dictionary           grant_type= password
    ...                         client_id= ${consumer_key}
    ...                         client_secret= ${consumer_secret}
    ...                         username= ${username}
    ...                         password= ${password}
    ${resp} =                   Post On Session             sfauth                  /services/oauth2/token    params=${params}
    Should Be Equal As Strings                              ${resp.status_code}     200
    Log                         ${resp.json()}
    #[Return]                   ${resp.json()}
    ${pat}=                     Get From Dictionary         ${resp.json()}          access_token
    Set Suite Variable          ${pat}

Create Account via API and capture Account ID
    ${account_data}=            SF API Create Account Record
    ${account_id}=              Get From Dictionary         ${account_data}         id
    Set Suite Variable          ${account_id}

SOQL Query and paratermize JSON response
    ${soql_response}=           SF API SOQL Query Account Record
    ${name}=                    Get From Dictionary         ${soql_response}        Name
    Set Suite Variable          ${name}                     

Validate Account Record Created in UI 
    Home
    ClickText                   Accounts
    VerifyText                  ${name}
    ClickUntil                  Delete                      ${name}
    Clicktext                   Delete
    ClickText                   Delete                      anchor=Cancel



