*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Create New PRCR
    [tags]                    Permission Request
    [Documentation]           Test to create PRCR under Permission Request with two part CRT script for deletion
    Appstate                  Home 
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    TypeText    Search this list...    PR-00024934\n    anchor=License, Title Id, Title Name, End Date, Created Date, Is PRM, Owner Last Name, and Stop Reminder Emails aren't searchable. Use filters or sort on these fields instead.
    Sleep        2s
    ClickText    PR-00024934
    VerifyText   PR-00024934
    ClickText    Related

#Create new PRCR 
    ClickText    Permission Request Contact Roles     anchor=New
    ClickText    New
    UseModal     On
    ComboBox     Search Accounts...    Avignon University
    ComboBox     Search Contacts...    Auto CRT
    ClickText    Save    partial_match=False
    UseModal     Off
    Sleep        2s
    ClickText    PR-00024934
    ClickText    Related
    ClickText    Permission Request Contact Roles

#Check new PRCR is created
#    ${exists}=         Is Text          Select Item 1    timeout=2
#    IF  ${exists}
#        ClickCheckbox    Select Item 1    on    partial_match=False
#        HotKey       Tab
#        ClickText    PRCR                 anchor=Contact
#        VerifyText    Permission Request Contact Role\nPRCR
#        HoverText    Avignon University
#        VerifyText    Auto CRT
#        ClickText    PR-00024934
#        Log          New PRCR successfully created
#    ELSE            
#        Log  No New PRCR successfully created
#    END

