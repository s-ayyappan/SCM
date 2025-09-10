*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Accounts Tab  UI
    [tags]                    Accounts
    [Documentation]           Accounts tab UI check
    Appstate                  Home
    LaunchApp                 Accounts
    Sleep                     2s