*** Settings ***
Library    QWeb
Resource                        ../Common/common.robot
Resource                        settings.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite

*** Test Cases ***
Localization Testing With ${Language}
    GoTo    https://www.scotiabank.com/global/en/global-site.html
    ClickText     ${language}
    VerifyText    ${welcomeBanner}
    VerifyText    ${welcomeButton}
    ClickText     ${welcomeButton}


   