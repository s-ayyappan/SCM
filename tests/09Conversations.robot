*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Conversations Tab UI Checks
    [tags]                    Conversations
    [Documentation]           Conversations tab UI check
    Appstate                  Home
    LaunchApp                 Conversations
    Sleep                     2s

#check the UI components in Conversations tab


    ClickText    Select a List View: Conversations
    ClickText    All
    ClickText    1st addendum NANDA -CPM license 2016-2018 license updating
    VerifyText   Conversation
    ClickText    Related
    ClickText    Details
    VerifyText   Name    
    VerifyText   Account    
    VerifyText   License    
    VerifyText   Is Sensitive   
    VerifyText   Owner   
    VerifyText   Project   
    VerifyText   Email Management
    HoverText    Edit
    HoverText    New Contact
    HoverText    New Opportunity
    
