*** Settings ***
*** Variables ***
${device}    Samsung Galaxy S20 Ultra
*** Keywords ***
Handle Cookies Prompt
    ${cookiesPrompt}=     IsText                    Before you continue to Google
    IF    ${cookiesPrompt}
        ClickText         Accept all
    END
