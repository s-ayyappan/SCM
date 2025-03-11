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
    Sleep        2s
    ClickText    Related
    SwipeDown
    ClickItem    Conversations
    VerifyText   Conversations
#create a new conversation
    ClickText    New
    UseModal     On
    TypeText     *Name    Robot Conversation
    ClickText    Save    partial_match=False
    UseModal     Off
    Sleep        2s
    ClickText    Robot Conversation
    VerifyField  Name    Robot Conversation    partial_match=True
    ClickText    Robot Conversation
#edit the conversation to add account details
    ClickText    Edit Account
    Sleep        2s
    ScrollText   Recent Items
    ComboBox     Search Accounts...    Robot Account
    ClickText    Save
    Sleep        2s
    VerifyField  Account    Robot Account    tag=a    partial_match=True
    ClickFieldValue    Account
#check whether the newly added conversation is list under conversations
    ClickText    Related
    SwipeDown
    ClickItem    Conversations
    VerifyText   Conversations
    VerifyText    Robot Conversation
    






