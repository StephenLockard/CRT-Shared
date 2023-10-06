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
    LaunchApp    Sales
    ClickText                   Accounts
    VerifyText                  ${name}
    ClickText    Show more actions
    ClickUntil                  Delete                      ${name}
    Clicktext                   Delete
    ClickText                   Delete                      anchor=Cancel



