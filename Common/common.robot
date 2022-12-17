*** Settings ***
Library                         QForce
Library                         QWeb
Library                        
Library                         String
Library                         DateTime


*** Variables ***
${BROWSER}                      chrome

${username}                     CRT-Short@Copado.com
${loginUrl}                    https://slockard-dev-ed.lightning.force.com/
${homeUrl}                     ${loginUrl}/lightning/page/home
${applauncher}                  //*[contains(@class, "appLauncher")]

${company}                      ExampleCorp
${accountName}                  ExamplaryBranch
${first}                        Demo
${last}                         McTest
${email}                        DTest@test.test
${phone}                        1234567890

${demoFirst}                    Marty
${demoLast}                     McFly



*** Keywords ***
Setup Browser
    Set Library Search Order    QWeb
    Evaluate                    random.seed()
    Open Browser                about:blank                 ${BROWSER}    
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    SetConfig                   DefaultTimeout              20s                         #sometimes salesforce is slow
    SetConfig                   CaseInsensitive             True
Form Fill
    [Documentation]             This requests a demo
    TypeText                    First Name*                 Marty
    TypeText                    Last Name*                  McFly
    TypeText                    Business Email*             delorean88@copado.com
    TypeText                    Phone*                      1234567890
    TypeText                    Company*                    Copado
    DropDown                    Employee Size*              1-2,500
    TypeText                    Job Title*                  Sales Engineer
    DropDown                    Country                     United States
End suite
    Close All Browsers

Form fill demo
    TypeText                   First Name*                 Marty
    TypeText                   Last Name*                  McFly
    TypeText                   Business Email*             delorean88@copado.com
    TypeText                   Phone*                      1234567890
    TypeText                   Company*                    Copado
    DropDown                   Employee Size*              1-2,500
    TypeText                   Job Title*                  Sales Engineer
    DropDown                   Country                     Netherlands

Form Fill Training
    [Documentation]    This keyword was generated during the training and can be used to fill in the form on the copado website
    TypeText                   First Name*                 Marty
    TypeText                   Last Name*                  McFly
    TypeText                   Business Email*             delorean88@copado.com
    TypeText                   Phone*                      1234567890
    TypeText                   Company*                    Copado
    DropDown                   Employee Size*              1-2,500
    TypeText                   Job Title*                  Sales Engineer
    DropDown                   Country                     Netherlands
Login
    [Documentation]             Login to Salesforce instance
    GoTo                        ${loginUrl}
    TypeText                    Username                    ${username}
    TypeText                    Password                    ${password}
    ClickText                   Log In
    # ${isMFA}=                   IsText                      Verify Your Identity        #Determines MFA is prompted
    # Log To Console              ${isMFA}
    # IF                          ${isMFA}                    #Conditional Statement for if MFA verification is required to proceed
    #     ${mfa_code}=            GetOTP                      ${username}                 ${MY_SECRET}                ${password}
    #     TypeSecret              Code                        ${mfa_code}
    #     ClickText               Verify
    # END

Setup       
    GoTo                        ${login_url}lightning/setup/SetupOneHome/home

Home
    [Documentation]             Navigate to homepage, login if needed
    End suite
    Setup Browser
    GoTo                        ${homeUrl}
    ${login_status}=            IsText                      To access this page, you have to log in to Salesforce.                 2
    Run Keyword If              ${login_status}             Login
    VerifyText                  Home

InsertRandomValue
    [Documentation]             This keyword accepts a character count, suffix, and prefix.
    ...                         It then types a random string into the given field.
    ...                         This is an example of generating dynamic data within a test
    ...                         and how to create a keyword with optional/default arguments.
    [Arguments]                 ${field}                    ${charCount}=5              ${prefix}=                  ${suffix}=
    Set Library Search Order    QWeb
    ${testRandom}=              Generate Random String      ${charCount}
    TypeText                    ${field}                    ${prefix}${testRandom}${suffix}


VerifyNoAccounts
    VerifyNoText                ${accountName}              timeout=3


DeleteData
    [Documentation]             RunBlock to remove all data until it doesn't exist anymore
    ClickText                   ${accountName}
    ClickText                   Delete
    VerifyText                  Are you sure you want to delete this account?
    ClickText                   Delete                      2
    VerifyText                  Undo
    VerifyNoText                Undo
    ClickText                   Accounts                    partial_match=False

Cleanup                   
    Login
    Sleep                       3
    LaunchApp                   Sales
    ClickText                   Accounts
    RunBlock                    VerifyNoAccounts            timeout=180s                exp_handler=DeleteData
    Sleep                       3

MFA Login
    ${isMFA}=                   IsText                      Verify Your Identity        #Determines MFA is prompted
    Log To Console              ${isMFA}
    IF                          ${isMFA}                    #Conditional Statement for if MFA verification is required to proceed
        ${mfa_code}=            GetOTP                      ${username}                 ${MY_SECRET}                ${password}
        TypeSecret              Code                        ${mfa_code}
        ClickText               Verify
    END
