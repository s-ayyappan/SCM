*** Settings ***
Library           QForce
Library           QWeb
Library           DataDriver    reader_class=TestDataApi    name=TestDATA.csv
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Delete Conversation
    [tags]                    Accounts  Conversations Delete
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Accounts
        
#ClickItem    search-button
    TypeText     Search this list...    Robot Account\n    anchor=PRM Account, Owner Last Name, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText    Robot Account
    VerifyText   Robot Account
    Sleep        2s
    ClickText    Related
    SwipeDown
    ClickItem    Conversations
    VerifyText   Conversations
#search the conversation 
    TypeText     Search this list...    Robot conversation\n    anchor=Project, Account, License, Is Sensitive, Owner First Name, and Owner Last Name aren't searchable. Use filters or sort on these fields instead.
    ClickText    Robot Conversation
#check whether the conversation is found
     ${status} =   Run Keyword And Return Status  Page Should Contain  Nothing to see here
    Run Keyword If  ${status}  Log  "Login successful"  level=INFO
    Run Keyword Unless  ${status}  Log  "Nothing to see here"  level=ERROR
    ClickText    Show more actions
#Delete a conversation
    ClickText    Delete
    UseModal     On
    ClickText    Delete
    UseModal     Off
    






