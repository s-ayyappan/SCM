*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Create Contract Agreement
    [tags]                    Permission Request, Contract Agreement
    [Documentation]           Test to create new Contract Agreement
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    HoverText    Show Actions
    TypeText     Search this list...    PR-00000015\n    anchor=Clear
    ClickText    PR-00000015
    VerifyText   PR-00000015
    ClickText    Related
    ClickText    Details