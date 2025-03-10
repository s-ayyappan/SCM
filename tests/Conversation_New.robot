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
    TypeText     Search...    Robot account\n
    Sleep        4s
    ClickText    Robot Account
    Sleep        4s
    VerifyText   Robot Account      
#Clickt the related tab

    ClickText    Related
    ClickText    Related
    ScrollText    Recent Items
    ClickText    (1)
    ScrollText    /html[1]/head[1]/link[1]
    ClickText    New
    UseModal    On
    TypeText    *Name    Robot Conversation
    ClickText    Save    partial_match=False
    UseModal    Off
    HoverText    Save & New
    ClickText    Robot Conversation
    VerifyField    Is Sensitive    Is Sensitive    partial_match=True
    ClickFieldValue    Is Sensitive
    ClickFieldValue    Account




