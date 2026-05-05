*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check SDM app Loading
    [tags]                    Project
    [Documentation]           Check the SDM App is loading with all necessary objects
    Appstate                  Home
    Sleep                     2s
    LaunchApp    SDM

#check the UI components for SDM app
    VerifyText    SDM
    ClickText    Accounts
    ClickText    Contacts
    HoverText    Sources
    ClickText    Sources
    ClickText    Licenses
    ClickText    Permission Requests
    ClickText    Contract Agreements
    ClickText    Projects

