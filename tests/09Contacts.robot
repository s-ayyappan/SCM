*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Contracts Tab UI Checks
    [tags]                    Contacts
    [Documentation]           Contacts tab UI check
    Appstate                  Home
    LaunchApp                 Contacts
    Sleep                     2s

#check the UI components in Contacts tab

    VerifyText    Contacts
    VerifyText    New
    VerifyText    New
    VerifyText    Import
    VerifyText    Account Name
    VerifyText    Name
    VerifyText    Title
    VerifyText    Phone
    VerifyText    Email
    VerifyText    Owner Last Name
