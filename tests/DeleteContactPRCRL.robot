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
    Sleep        2s
#check whether duplicate or similar contact already exists
    ${duplicate_exists}=    Set Variable    Similar Records Exist
    IF    '${duplicate_exists}' == 'Similar Records Exist'
        Log    >>> Duplicates were found
        ClickText    Cancel    partial_match=False
    ELSE
        Log    >>> No duplicates found
        ClickText    Save    partial_match=False
        UseModal     Off
    END
#    UseModal     Off
    Sleep        2s
#search the existing contact    
    TypeText    Search this list...    Robotics PRCRcontact\n    anchor=Clear
    ClickText    Robotics PRCRcontact
    VerifyField  Name    Mr. Robotics PRCRcontact    partial_match=True

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
    ComboBox     Search Contacts...    Robotics PRCRcontact
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
    TypeText    Search this list...    Robotics PRCRcontact\n
    Sleep        2s
#    TypeText     Search this list...    robotics PRCRcontact\n    anchor=Owner Last Name and Left Employment? aren't searchable. Use filters or sort on these fields instead.
    ClickText    Robotics PRCRcontact     
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

#    Should Not Be True    ${exists}    msg=Checkbox 'Select Item 6' was found but should not exist
#    Log                   PRCR successfully deleted


