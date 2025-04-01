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
    VerifyText   Cases
    ClickText    New
    UseModal     On
    ClickText    Next    anchor=Cancel
    ComboBox     Search Contacts...    Robotics contact
    ComboBox     Search Accounts...    Aalborg University
    PickList     *Case Origin    Email
    ClickText    Save    partial_match=False
    UseModal     Off
    VerifyField  Contact Name    Robotics contact    tag=a    partial_match=True

#delete the contact    
    LaunchApp    Contacts
    TypeText     Search this list...    robotics contact\n    anchor=Owner Last Name and Left Employment? aren't searchable. Use filters or sort on these fields instead.
    ClickText    Robotics contact     
    UseModal     On
    ClickText    Delete
    Sleep        1s
    ClickText    Delete
    Sleep        2s
    ${result}    Run Keyword And Ignore Error  VerifyText   Nothing to see here
    log          Verification Result: ${result}

#delete the contact
    #ClickText    Delete
    #UseModal     On
    #ClickText    Delete
    #UseModal     Off
    #TypeText     Search this list...    robotics contact\n    anchor=Date/Time Opened and Case Owner Alias aren't searchable. Use filters or sort on these fields instead.
    #VerifyText   Nothing to see here

#chech the case does not have deleted contact reference
    LaunchApp    Cases
    ClickItem    search-button
    VerifyText   00001694
    TypeText     Search...    00001694\n
    ClickText    Case Number
    VerifyText   00001694
    ClickText    00001694    anchor=Case Number
    VerifyField  Contact Name    ${EMPTY}
    Log          Case does not have deleted contact reference      
