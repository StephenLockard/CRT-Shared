*** Settings ***
Resource                        ../Common/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite

*** Test Cases ***
Upload Files Test
    SetConfig      AllInputElements    //input[@type="file"]
    Home
    GoTo    https://slockard-dev-ed.lightning.force.com/lightning/r/Account/0017Q000018oPgrQAE/view
    UploadFile      //input[@type\="file"]     test.txt             visibility=False
    