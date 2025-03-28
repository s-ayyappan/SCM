*** Settings ***
Library           QForce
Library           QWeb
Library           QVision
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Delete Contact and Case
    [tags]                    Contacts Cases
    [Documentation]           Delete the Contact then case relation is removed  
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Contacts
#create a new contact for robotics testing


    ClickText    New
    UseModal     On
    PickList     Salutation    Mr.
    TypeText     First Name    Robotics
    TypeText     Last Name    contact
    TypeText     OBII Id    222343\n
    PickList     Contact Role    All-round
    ComboBox     Search Accounts...    Aalborg University
    TypeText     Email    test@elsevier.invalid.com    
    ClickText    Save    partial_match=False
    UseModal     Off
    VerifyField  Name    Mr. Robotics contact    partial_match=True

#create new case 
    LaunchApp    Cases
    VerifyText    Cases
    ClickText    New
    UseModal    On
    ClickText    Next    anchor=Cancel
    ComboBox     Search Contacts...    Robotics contact
    ComboBox     Search Accounts...    Aalborg University
    PickList     *Case Origin    Email
    ClickText    Save    partial_match=False
    UseModal     Off
    VerifyField  Contact Name    Robotics contact    tag=a    partial_match=True

#delete the case

    ClickText    Delete
    UseModal     On
    ClickText    Delete
    UseModal     Off
    TypeText     Search this list...    robotics contact\n    anchor=Date/Time Opened and Case Owner Alias aren't searchable. Use filters or sort on these fields instead.
    VerifyText   Nothing to see here

#delete the contact    
    LaunchApp    Contacts
    TypeText     Search this list...    robotics contact\n    anchor=Owner Last Name and Left Employment? aren't searchable. Use filters or sort on these fields instead.
    ClickText    Robotics contact     
    UseModal     On
    ClickText    Delete
    ClickText    Delete
    Sleep        1s
    VerifyText   Nothing to see here
#wait until the UAT deployment of sCMS1019 ticket