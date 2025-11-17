*** Settings ***
Library    QForce
Library    QWeb
Library    QVision
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Delete Contact and linked PRCR
    [tags]                    Permission Request
    [Documentation]           Test to check while deleting contact, then connected PRCR is deleted
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Contacts

#create a new contact for this session
    ClickText   Contacts
    ClickText   New
    UseModal    On
    PickList    Salutation    --None--
    TypeText    First Name    Automation
    TypeText    Last Name    CRTPRCR
    ComboBox    Search Accounts...    Aalborg University
    TypeText    Email    crtPRCR@elsevier.invalid.com
    ClickText         Save
#check whether duplicate or similar contact already exists
    ${duplicate_exists}=    Set Variable    Similar Records Exist
    IF    '${duplicate_exists}' == 'Similar Records Exist'
        Log    >>> Duplicates were found
        ClickText    Cancel    partial_match=False
    ELSE
        Log    >>> No duplicates found
        ClickText    Save    partial_match=False
    END

#search the existing contact    
    ClickText   Contacts
    ClickText    Select a List View: Contacts
    ClickText    All Contacts
    TypeText    Search this list...    Automation CRTPRCR\n    anchor=Clear
    ClickText    Automation CRTPRCR
    VerifyField  Name    Automation CRTPRCR    partial_match=True

#navigate to existing PR
    LaunchApp    Permission Requests
    Sleep        2s
    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    TypeText    Search this list...    PR-00024512\n    anchor=License, Title Id, Title Name, End Date, Created Date, Is PRM, Owner Last Name, and Stop Reminder Emails aren't searchable. Use filters or sort on these fields instead.
    Sleep        2s
    ClickText    PR-00024512
    VerifyText   PR-00024512
    ClickText    Related

#Create new PRCR 
    VerifyText   Contract Agreements                    anchor=Change Owner
    SwipeDown
    VerifyText   Permission Request Contact Roles      anchor=New
    ClickText    Permission Request Contact Roles
    ClickText    New    parent=LIGHTNING-BUTTON
    UseModal     On
    ComboBox     Search Accounts...    Aalborg University
    ComboBox     Search Contacts...    Automation CRTPRCR
    ClickText    Save    partial_match=False
    UseModal     Off
    Sleep        2s

#capture the new PRCR details
    ClickText    PR-00024512
    ClickText    Related
    ClickText    Permission Request Contact Roles           anchor=New
    ClickCheckbox    Select Item 4    on    partial_match=False
    ClickText        PRCR             anchor=Select Item 4
    ${prcrValue}=    GetText            Permission Request Contact Role 

#delete the contact    
    LaunchApp    Contacts
    RefreshPage
    Sleep        2s 
    HoverText    Left Employment?
    TypeText    Search this list...    Automation CRTPRCR\n
    Sleep        2s
#    TypeText     Search this list...    robotics CRTPRCR\n    anchor=Owner Last Name and Left Employment? aren't searchable. Use filters or sort on these fields instead.
    ClickText    Automation CRTPRCR     
    UseModal     On
    ClickText    Delete
    Sleep        1s
    ClickText    Delete
    Sleep        2s
    ${result}    Run Keyword And Ignore Error  VerifyText   Nothing to see here
    Log          Verification Result: ${result}

#refresh the page to check PRCR is deleted
    RefreshPage
    Sleep        2s 
    Appstate     Home
    Sleep        2s
    LaunchApp    Permission Requests
    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    RefreshPage
    Sleep        2s 
    TypeText    Search this list...    PR-00024512\n
    Sleep        2s
    ClickText    PR-00024512
    VerifyText   PR-00024512
    ClickText    Related
    ClickText    Permission Request Contact Roles           anchor=New

# First verify that checkbox is not present using Is Text
    ${exists}=         Is Text          Select Item 4

# Verify the checkbox does not exist (exists should be False)
    IF  ${exists}
        ClickCheckbox    Select Item 4    on    partial_match=False
        Log  PRCR is not deleted when contact is deleted
    ELSE            
        Log  PRCR not found, skipping this step
    END    




