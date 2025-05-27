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
    ${prtext} =  GetText    Permission Request Name            
    ClickText    Related
    ClickText    Details

#navigate to the account of PR
    
    ClickText    Dean Witter Foundation
    ClickText    Related
    SwipeDown
    ClickText    Permission Requests
    ClickText    PR-00024535

    VerifyText   Permission Request Name
    ${prtextaccount}=  GetText         Permission Request Name
    IF    "${prtext}" == "${prtextaccount}"
        Log    Same PR exist in Account Related tab
        VerifyText    ${prtext}    timeout=10
    ELSE
        Log    PR texts do not match
    END
 

