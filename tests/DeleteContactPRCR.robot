*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Delete Contact and linked PRCR
    [tags]                    Permission Request
    [Documentation]           Test to check while deleting contact, then connected PRCR is deleted
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Permission Requests


#create a new contact for robotics testing
    ClickText    New
    UseModal     On
    PickList     Salutation    Mr.
    TypeText     First Name    Robotics
    TypeText     Last Name    PRCRcontact
    TypeText     OBII Id    222343\n
    PickList     Contact Role    All-round
    ComboBox     Search Accounts...    Aalborg University
    TypeText     Email    test@elsevier.invalid.com    
    ClickText    Save    partial_match=False
    UseModal     Off
    VerifyField  Name    Mr. Robotics contact    partial_match=True

#navigate to existing PR
    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    TypeText    Search this list...    PR-00024512\n    anchor=License, Title Id, Title Name, End Date, Created Date, Is PRM, Owner Last Name, and Stop Reminder Emails aren't searchable. Use filters or sort on these fields instead.
    Sleep        2s
    ClickText    PR-00024512
    VerifyText   PR-00024512
    ClickText    Related

#Create new PRCR 
    ClickText    Permission Request Contact Roles
    ClickText    New
    UseModal     On
    ComboBox     Search Accounts...    Aalborg University
    ComboBox     Search Contacts...    Robotics PRCRcontact
    ClickText    Save    partial_match=False
    UseModal     Off

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
    Log          Verification Result: ${result}




    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    TypeText     Search this list...    PR-00024512\n    anchor=License, Title Id, Title Name, End Date, Created Date, Is PRM, Owner Last Name, and Stop Reminder Emails aren't searchable. Use filters or sort on these fields instead.
    Sleep        2s
    ClickText    PR-00024512
    VerifyText   PR-00024512
    ClickText    Related

#Create new PRCR 
    ClickText    Permission Request Contact Roles
    ClickText    New
    UseModal     On
    ComboBox     Search Accounts...    Aalborg University
    ComboBox     Search Contacts...    Julie Roy
    ClickText    Save    partial_match=False
    UseModal     Off

#clean up the newly created PRCR
    RefreshPage
    ClickText    Permission Request Contact Roles
    ClickCheckbox    Select Item 6    on    partial_match=False
    ClickText    Show Actions    anchor=Ramadurga Muthuirlandy
    Sleep        2s
    ClickText    Delete
    UseModal     On
    ClickText    Delete
    UseModal     Off
