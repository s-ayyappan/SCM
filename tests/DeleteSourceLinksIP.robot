*** Settings ***
Library    QForce
Library    QWeb
Library    QVision
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Delete Contact and linked Source Link
    [tags]                    Permission Request, Contacts
    [Documentation]           Test to check while deleting contact, then connected Source link is deleted
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
#check whether duplicate or similar contact already exists
    ${duplicate_exists}=    Set Variable    Similar Records Exist
    IF    '${duplicate_exists}' == 'Similar Records Exist'
        Log    >>> Duplicates were found
        ClickText    Cancel    partial_match=False
    ELSE
        Log    >>> No duplicates found
        ClickText    Save    partial_match=False
    END
    UseModal     Off
    Sleep        2s
#search the existing contact    
    TypeText    Search this list...    Robotics PRCRcontact\n    anchor=Clear
    ClickText    Robotics PRCRcontact
    VerifyField  Name    Mr. Robotics PRCRcontact    partial_match=True
