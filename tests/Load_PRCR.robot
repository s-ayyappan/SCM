*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check PRCR Loading
    [tags]                    Permission Request
    [Documentation]           Test to check PRCR under Permission Request is loading as normal
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    HoverText    Show Actions
    TypeText     Search this list...    PR-00024512\n    anchor=Clear
    Sleep        2s
    ClickText    PR-00024512
    VerifyText   PR-00024512
    ClickText    Related
    ClickText    Details
   
    ClickText    Related
#Click the PRCR and allow it to load and check the PR
    ClickText    PRCR-00016265
    Sleep        2s
    VerifyText   Permission Request Contact Role
    VerifyText   PR-00024512
    ClickText    PR-00024512

