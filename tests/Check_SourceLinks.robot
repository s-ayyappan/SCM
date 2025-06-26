*** Settings ***
Library    QForce
Library    QVision
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Source links loading in the PR
    [tags]                    Permission Request, Source links
    [Documentation]           Check the Source links loading for the PR
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    HoverText    Show Actions
    TypeText     Search this list...    PR-00000130\n    anchor=Clear
    Sleep        2s
    ClickText    PR-00000130
    VerifyText   PR-00000130
    ClickText    Related
    Sleep        2s