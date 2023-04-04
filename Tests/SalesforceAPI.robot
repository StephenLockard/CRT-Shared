*** Settings ***

Documentation           Example on how to use QForce REST API keywords
Library                 QForce
Resource                        ../Common/common.robot
Resource                        settings.robot
Suite Setup             Setup Browser
Suite Teardown          End Suite


*** Variables ***
#${username}                     # SHOULD BE GIVEN IN CRT VARIABLES SECTION
#${login_url}                    # SHOULD BE GIVEN IN CRT VARIABLES SECTION
#${password}                     # SHOULD BE GIVEN IN CRT SENSITIVE VARIABLES SECTION
#${client_id}                    # SHOULD BE GIVEN IN CRT SENSITIVE VARIABLES SECTION
#${client_secret}                # SHOULD BE GIVEN IN CRT SENSITIVE VARIABLES SECTION


*** Test Cases ***
Create Account and Contact via REST API
    [Documentation]             Example test case on how to create test data using REST API
    [tags]                      REST API                    Create

    # --------------------------NOTE-------------------------------------------------------- 
    # Authentication needs to be done once prior to using other REST API keywords
    # For authentication a client_id and client secret from a Connected oauth app are needed
    # in addition to test user's credentials     
    # --------------------------------------------------------------------------------------           
    Authenticate                ${consumer_key}                ${consumer_secret}    ${username}           ${password}     sandbox=True 
  
    # --------------------------NOTE-------------------------------------------------------- 
    # For creating data, just use keyword "Create Record" with data type you want to 
    # create + fields and values
    # --------------------------------------------------------------------------------------   
    ${my_acc}=                  Create Record               Account             Name=TestCorp123
    ${my_contact}=              Create Record               Contact             FirstName=Jane        LastName=Doe  

    # --------------------------NOTE-------------------------------------------------------- 
    # id of created records is returned and stored in variables above.
    # Let's make these suite level variables, so that we can re-use them later
    # --------------------------------------------------------------------------------------   
    Set Suite Variable          ${my_acc}
    Set Suite Variable          ${my_contact}


Get Record Info
    [Documentation]             Example test case on how to query data using REST API
    [tags]                      REST API                    Get

    # --------------------------NOTE-------------------------------------------------------- 
    # Get Record returns record info as json. You can use them as dictionaries, i.e.
    # ${contact}[Name]
    # --------------------------------------------------------------------------------------   
    ${account}=                 Get Record                  Account             ${my_acc}
    Should Be Equal As Strings                              ${account}[Name]    TestCorp123
    Log                         ${account}
    ${contact}=                 Get Record                  Contact             ${my_contact}
    Log                         ${contact}
    Should Be Equal As Strings                              ${contact}[Name]    Jane Doe


Update data and verify
    [Documentation]             Example test case on how to modify and verify data
    [tags]                      REST API                    Update

    # --------------------------NOTE-------------------------------------------------------- 
    # Update Record keywords takes record type and field/data to update as argument
    # Note that we link the contact to an account here.
    # -------------------------------------------------------------------------------------- 
    Update Record               Contact                     ${my_contact}    FirstName=Jana    Email=jana.doe@fake.com    AccountId=${my_acc}
    Verify Record               Contact                     ${my_contact}    FirstName=Jana    LastName=Doe     Email=jana.doe@fake.com    AccountId=${my_acc}


Verify from UI
    [Documentation]             Example test case where data updated via REST API is verified on UI
    [tags]                      UI

    # --------------------------NOTE-------------------------------------------------------- 
    # Let's verify changes on UI as well
    # -------------------------------------------------------------------------------------- 
    AppState                    Home
    LaunchApp                   Sales
    ClickText                   Contacts
    VerifyPageHeader            Contacts
    VerifyText                  New
    VerifyText                  Jana Doe
    ClickText                   Jana Doe

    ClickText                   Details
    VerifyField                 Name                     Jana Doe
    VerifyField                 Email                    jana.doe@fake.com
    VerifyField                 Account Name             TestCorp123    tag=a

    # We'll take a screenshot to the log
    LogScreenshot
    

SOQL query and List objects
    [Documentation]             Example test case for demonstrating other REST API keywords in QForce
    [tags]                      REST API                    Misc    Query

    # --------------------------NOTE-------------------------------------------------------- 
    # We can query/manipulate data using SOQL Query. See:
    # https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/dome_query.htm
    # -------------------------------------------------------------------------------------- 
    ${results}=                 QueryRecords                SELECT id,name from Contact WHERE name LIKE 'Jana%' 
    Log                         ${results}

    # --------------------------NOTE-------------------------------------------------------- 
    # We can list all record types this user has access/visibility to
    # ListObjects will log all object types available for the user
    # -------------------------------------------------------------------------------------- 
    ListObjects


Delete Records
    [Documentation]             Example test case on how to delete data and revoke access token
    [tags]                      REST API                    Delete

    # --------------------------NOTE-------------------------------------------------------- 
    # Delete Record keywords takes record type to be deleted and id as an argument
    # -------------------------------------------------------------------------------------- 
    Delete Record               Contact                     ${my_contact}
    Delete Record               Account                     ${my_acc}

    # --------------------------NOTE-------------------------------------------------------- 
    # Revoke access token so that it can not be used anymore
    # Get Record should fail as token is not valid anymore
    # -------------------------------------------------------------------------------------- 
    Revoke
    Run Keyword And Expect Error    ValueError: Token not set*                 Get Record                  Account            ${my_acc}