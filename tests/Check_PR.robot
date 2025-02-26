# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Permission Requests
    [tags]                    Permission Request
    Appstate                  Home
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    HoverText    Show Actions
    TypeText     Search this list...    PR-00000130\n    anchor=Clear
    ClickText    PR-00000130
    VerifyText   PR-00000130
    ClickText    Related
    ClickText    Details
    
    
