*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Related Permission Requests for Account
    [tags]                    Permission Request
    [Documentation]           Test to Check Related Permission Requests for Account
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    HoverText    Show Actions
    TypeText     Search this list...    PR-00024535\n    anchor=Clear
    ClickText    PR-00024535
    VerifyText   PR-00024535
    ${prtext} =  
    ClickText    Related
    ClickText    Details

#navigate to the account of PR
    
    ClickText    Dean Witter Foundation
    ClickText    Related
    ScrollText    Recent Items
    ScrollText    Recent Items

    ClickText    PR-00024535

    VerifyText    Permission Request Name
    VerifyText    Permission Request Name\nPR-00024535
 

