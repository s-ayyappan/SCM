*** Settings ***
Library           QForce
Library           QWeb
Library           QVision
Library           String
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite

*** Test Cases ***
Un-tag contacts from related cases before deletion
#scms-911 ticket functionality
    [tags]                    Cases
    [Documentation]           Un-tag Contacts from related cases before deletion     
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Contacts

#create a new contact for this session
    ClickText   Contacts
    ClickText   New
    UseModal    On
    PickList    Salutation    --None--
    TypeText    First Name    Automation
    TypeText    Last Name    CRT
    ComboBox    Search Accounts...    Codogno Hospital
    TypeText    Email    crt@elsevier.invalid.com
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

#create a case for automation
    LaunchApp    Cases
    HoverText    New
    ClickText    New
    UseModal     On
    ClickText    Next
    VerifyText   Contact Name
    ComboBox     Search Contacts...    Automation CRT
    PickList     *Case Origin    Email

#save the new case with new contact created
    ClickText    Save    partial_match=False
    ClickText    Related
    ClickText    Details

#new case with newly create contact tagged
    HoverText    Automation CRT
    VerifyField   Contact Name    Automation CRT    tag=a    partial_match=True
    ClickFieldValue    Contact Name
    ClickText    Related
    
#delete the contact
    VerifyText   Automation CRT
    ClickText    Delete
    UseModal     On
    ClickText    Delete
    UseModal     Off
    VerifyText   Contact "Automation CRT"


#contact name removed from the case
    VerifyField  Contact Name    ${EMPTY}

#delete the case created for automation purpose
    ClickText    Delete
    UseModal     On
    ClickText    Delete
    UseModal     Off
    VerifyText   was deleted. Undo
