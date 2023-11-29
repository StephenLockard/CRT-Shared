*** Settings ***
Resource                        ../Common/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite

*** Test Cases ***
Upload Files Test
    Home
    GoTo    https://slockard-dev-ed.lightning.force.com/lightning/r/Account/0017Q000018oPgrQAE/view
    UploadFile    Upload Files    ../README.md    anchor=or drop files