*** Settings ***
Resource                        ../Common/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite


*** Test Cases ***
PDF Testing   
    UsePdf    AITesting.pdf
    