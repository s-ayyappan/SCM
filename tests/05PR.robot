*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Permission Requests UI Check
    [tags]                    Permission Request
    [Documentation]           Test to check Permission Request edit UI                    
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    HoverText    Show Actions
    TypeText     Search this list...    PR-00025133\n    anchor=Clear
    ClickText    PR-00025133
    VerifyText   PR-00025133
    ClickText    Related
    ClickText    Details