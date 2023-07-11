*** Settings ***
*** Keywords ***
Handle Cookies Prompt
    ${cookiesPrompt}=     IsText                    Before you continue to Google
    IF    ${cookiesPrompt}
        ClickText         Accept all
    END
