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

#check the UI components in Contacts tab