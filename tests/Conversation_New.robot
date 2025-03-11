*** Settings ***
Library           QForce
Library           QWeb
Library           DataDriver    reader_class=TestDataApi    name=TestDATA.csv
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Check New Account Creation
    [tags]                    Accounts
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Accounts
        
#ClickItem    search-button
    TypeText     Search this list...    Robot Account\n    anchor=PRM Account, Owner Last Name, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText    Robot Account
    VerifyText   Robot Account
    ClickText    Related
    SwipeDown
    ClickItem    Conversations
    VerifyText   Conversations
    ClickText    New
    UseModal     On
    TypeText     *Name    Robot Conversation
    ClickText    Save    partial_match=False
    UseModal     Off
    ClickText    Robot Conversation
    VerifyField  Name    Robot Conversation    partial_match=True
    ClickText    Robot Conversation
    






