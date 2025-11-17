*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Check Contacts Tab UI Checks
    [tags]                    Contacts
    [Documentation]           Contacts tab loading check
    Appstate                  Home
    LaunchApp                 Contacts
    Sleep                     2s

#check the Contacts tab loading and components
    ClickText     Select a List View: Contacts
    ClickText     All Contacts
    TypeText      Search this list...    Aaron Miller\n   
    ClickText     Aaron Miller
    VerifyText    Contact
    VerifyText    Aaron Miller
    VerifyText    Account Name
    VerifyText    Title
    ClickText     Phone
    VerifyText    Email
    VerifyText    Contact Owner
    VerifyText    Name
    VerifyText    Aaron Miller
    VerifyText    Initials
    VerifyText    Account Name
    VerifyText    Title
    VerifyText    Email
    VerifyText    Departmen
    VerifyText    Reports To
    VerifyText    Contact Role
    VerifyText    Edit Reports 
    VerifyText    Left Employment?
    VerifyText    Inactive
    VerifyText    OBII Id
    VerifyText    Contact Owner
    VerifyText    Phone
    VerifyText    Mobile
    VerifyText    Home Phone
    VerifyText    Other Phone
    VerifyText    Description
    VerifyText    Do Not Call
    HoverText     Edit
    HoverText     Delete
    ClickText     Related
    VerifyText    Opportunities
    VerifyText    Related Accounts
    VerifyText    Notes
    VerifyText    Cases
    VerifyText    Permission Request Contact Roles
