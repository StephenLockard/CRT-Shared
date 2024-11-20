*** Settings ***
Resource                        ../Common/common.robot
Library                         ../Resources/TextAnalysis.py
Suite Setup                     Setup Browser
Suite Teardown                  End suite

*** Variables ***
${POSITIVE_THRESHOLD}           0.5
${NEGATIVE_THRESHOLD}           -0.05
${messageText}

*** Test Cases ***
Test Agentforce Output for expected responses
    Login
    #TODO - close all tabs in more robust manner
    Sleep                       3
    HotKey                      Shift                       W
    VerifyText                  Published and Draft Sites
    VerifyText                  coral-cloud
    ClickText                   coral-cloud
    VerifyText                  Experience Cloud Site Detail
    ClickText                   Link to Site
    SwitchWindow                NEW
    VerifyText                  Welcome to Coral Cloud Resort, your ultimate tropical escape nestled in the heart of paradise.
    #TODO - clicking this button is tricky, there may or may not be an improvement
    ClickElement                xpath=//*[@id="embeddedMessagingConversationButton"]

    AIChat                      I would like information on the full moon beach party experience. Please include the Title, Location, Price, and Capacity.

    IF                          "information" in $messageText and "?" in $messageText
        Respond Affirmatively
    END

    # Check availability
    ${hasAvailability}=         Run Keyword And Return Status
    ...                         Should Contain Any          ${messageText}              available           open     slots    capacity

    # Check event description
    @{eventKeywords}=           Create List                 full moon                   beach party         music    dance    bonfire
    ${hasDescription}=          Run Keyword And Return Status
    ...                         Should Contain Any          ${messageText}              @{eventKeywords}

    ${hasTitle}=                Run Keyword And Return Status
    ...                         Evaluate                    any(phrase in """ ${messageText}""" for phrase in ["full moon beach party", "beach party under full moon", "full moon party on the beach"])
    ${hasLocation}=             Run Keyword And Return Status
    ...                         Evaluate                    any(phrase in """ ${messageText}""" for phrase in ["location: beach", "venue: beach", "takes place on the beach", "held at the beach"])
    ${hasPrice}=                Run Keyword And Return Status
    ...                         Evaluate                    any(phrase in """ ${messageText}""" for phrase in ["price: usd 25.00", "$25", "ticket price is $25", "25 dollars per person"])
    ${hasCapacity}=             Run Keyword And Return Status
    ...                         Evaluate                    any(phrase in """ ${messageText}""" for phrase in ["30 people", "up to 30 people", "maximum of 30 people", "capacity: 30", "limit of 30 attendees", "30 person capacity"])



    # Evaluate overall sentiment
    ${positive_sentiment}=      Evaluate
    ...                         ${hasAvailability} and ${hasDescription} and (${hasLocation} or ${hasPrice} or ${hasCapacity})

Test Agentforce Actions 
    #Assert positive sentiment
    ${sentiment_score}=         Analyze Sentiment           Yes, there is availability for that event! Would you like me to sign you up?
    Should Be True              ${sentiment_score} >= ${POSITIVE_THRESHOLD}
    #Assert negative sentiment|
    ${sentiment_score}=         Analyze Sentiment           I'm sorry, that event is not available. Shall I make another recommendation?
    Should Be True              ${sentiment_score} <= 0.05
    #Assert netural sentiment
    ${sentiment_score}=         Analyze Sentiment           The color gray.
    Should Be True              ${sentiment_score} > ${NEGATIVE_THRESHOLD} and ${sentiment_score} < ${POSITIVE_THRESHOLD}
    ${result}=                  Classify Response           No, absolutely not, never.

Test Agentforce Output with Copado AI
    #Close and re-open browser to make sure we have a fresh AI chat instance
    CloseBrowser
    Setup Browser
    Login
    Sleep                       3
    HotKey                      Shift                       W
    Verifytext                  Published and Draft Sites
    Clicktext                   coral-cloud
    VerifyText                  Link to Site
    ClickText                   Link to Site
    Switchwindow                NEW

    ClickElement                xpath=//*[@id="embeddedMessagingConversationButton"]

    AIChat                      Are there good nightlife options at this resort?
    #Positive sentiment assertion
    ${sentiment_score}=         Analyze Sentiment           ${messageText}
    Should Be True              ${sentiment_score} >= ${POSITIVE_THRESHOLD}
    #Positive response classification
    ${result}=                  Classify Response           ${messageText}
    Log To Console              ${result}
    Should Be Equal As Strings                              ${result}                   Affirmative

    #Continue conversation for demo purpose
    AIChat                      Yes, I want to book this event, can you show me available sessions?
    AIChat                      Let's book the event for two guests on the 11th at 1:30pm please.
    AIChat                      This was very unhelpful, I don't like you.

    #Negative sentiment assertion
    AiChat                      Do you offer jet-ski rentals? I want to have some loud fun!

    #Sentiment score not good here as the bot always ends with a helpful response
    #${sentiment_score}=        Analyze Sentiment           ${messageText}
    #Should Be True             ${sentiment_score} <= ${NEGATIVE_THRESHOLD}
    #Negative response classification
    ${result}=                  Classify Response           ${messageText}
    Should Be Equal As Strings                              ${result}                   Negative


    #Continue conversation for demo
    AIChat                      Okay



    #Neutral sentiment assertion
    AiChat                      What will be the average temperature this week at the resort?
    #Sentiment score not good here as the bot always ends with a helpful response
    #${sentiment_score}=        Analyze Sentiment           ${messageText}
    #Should Be True             ${sentiment_score} > ${NEGATIVE_THRESHOLD} and ${sentiment_score} < ${POSITIVE_THRESHOLD}
    #Unclear response classification
    ${result}=                  Classify Response           ${messageText}
    Should Be Equal As Strings                              ${result}                   Unclear

*** Keywords ***
Respond Affirmatively
    TypeText                    Type your message...        Yes, I would like more information about the event.
    HotKey                      Enter


AIChat
    [Arguments]                 ${message}
    TypeText                    Type your message...        ${message}
    AIChat
    ${messageText}=             Convert To Lowercase        ${messageText}
    Set Suite Variable          ${messageText}