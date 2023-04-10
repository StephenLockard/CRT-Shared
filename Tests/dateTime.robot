*** Settings ***

Documentation                New test suite
Library                      QWeb
Library                      DateTime
Suite Setup                  Open Browser                about:blank                 chrome
Suite Teardown               Close All Browsers

*** Variables ***
${currentMonth}
${nextMonth}
${correctYear}
${firstDayNextMonth}

*** Test Cases ***
Working with Date Formats
    ${now}=                     Get Current Date

    ${timestamp}=               Convert Date                ${now}                      result_format=%b %d, %Y
    ${timestamp}=               Convert Date                ${now}                      result_format=%d %b %Y %I:%M %p
First day of next month
    ${firstDayNextMonth}=    First day of next month

*** Keywords ***

First day of next month
    Check Date
    Set Suite Variable       ${firstDayNextMonth}        ${nextMonth}/01/${correctYear}
    [Return]                 ${firstDayNextMonth}
Check Date
    ${currentMonth}          Get Current Date            result_format=%m
    ${correctYear}          Get Current Date            result_format=%Y
    Set Suite Variable                               ${correctYear}    
    IF                       '${currentMonth}' == '01'
        Set Suite Variable                               ${nextMonth}                02
        Log                  ${nextMonth}
    ELSE IF                  '${currentMonth}' == '02'
        Set Suite Variable                               ${nextMonth}                03
        Log                  ${nextMonth}
    ELSE IF                  '${currentMonth}' == '03'
        Set Suite Variable                               ${nextMonth}                04
        Log                  ${nextMonth}
    ELSE IF                  '${currentMonth}' == '04'
        Set Suite Variable                               ${nextMonth}                05           
        Log                  ${nextMonth}
    ELSE IF                  '${currentMonth}' == '05'
        Set Suite Variable                               ${nextMonth}                06
        Log                  ${nextMonth}
    ELSE IF                  '${currentMonth}' == '06'
        Set Suite Variable                               ${nextMonth}                07
        Log                  ${nextMonth}
    ELSE IF                  '${currentMonth}' == '07'
        Set Suite Variable                               ${nextMonth}                08
        Log                  ${nextMonth}
    ELSE IF                  '${currentMonth}' == '08'
        Set Suite Variable                               ${nextMonth}                09
        Log                  ${nextMonth}
    ELSE IF                  '${currentMonth}' == '09'
        Set Suite Variable                               ${nextMonth}                10
        Log                  ${nextMonth}
    ELSE IF                  '${currentMonth}' == '10'
        Set Suite Variable                               ${nextMonth}                11
        Log                  ${nextMonth}
    ELSE IF                  '${currentMonth}' == '11'
        Set Suite Variable                               ${nextMonth}                12
        Log                  ${nextMonth}
    ELSE IF                  '${currentMonth}' == '12'
        Set Suite Variable                               ${nextMonth}                01
        ${correctYear}=      Evaluate                    ${correctYear}+1
        Set Suite Variable                               ${correctYear}
        Log                  ${correctYear}
        Log                  ${nextMonth}
    END




