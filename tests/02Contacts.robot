*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Contacts Tab UI Checks
    [tags]                    Contacts
    [Documentation]           Contacts tab UI check
    Appstate                  Home
    LaunchApp                 Contacts
    Sleep                     2s

#capture the UI objects in New contact Modal
    ClickText    New
    UseModal    On
    VerifyText    New Contact
    VerifyText    Name
    VerifyText    OBII Id
    VerifyText    OBII Id
    VerifyText    First Name
    VerifyText    Name
    VerifyText    First Name
    VerifyPickList    Salutation    
    VerifyText    Middle Name
    VerifyText    *Last Name
    VerifyText    Suffix
    VerifyText    Initials
    VerifyText    Contact Owner
    VerifyText    *Account Name
    VerifyText    Phone
    VerifyText    Mobile
    VerifyText    Title
    VerifyText    Email
    VerifyText    Fax
    VerifyText    Department
    VerifyText    Home Phone
    VerifyText    Phone
    VerifyText    Reports To
    VerifyText    Other Phone
    VerifyText    Left Employment?    
    VerifyText    Description
    VerifyText    Do Not Call    
    VerifyText   Inactive   
    VerifyText   Save & New
    VerifyText   Cancel and close
    VerifyText   Save
    ClickText    Cancel and close
    UseModal    Off
