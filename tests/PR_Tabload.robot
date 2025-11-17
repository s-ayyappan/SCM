*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Permission Requests
    [tags]                    Permission Request
    [Documentation]           Test to check Permission Request Tab is loading as normal
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    HoverText    Show Actions
    TypeText     Search this list...    PR-00024535\n    anchor=Clear
    ClickText    PR-00024535
    VerifyText   PR-00024535
    ClickText    Related
    ClickText    Details
    
    
