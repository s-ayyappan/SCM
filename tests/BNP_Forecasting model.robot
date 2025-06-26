*** Settings ***
Library    QForce
Library    QVision
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check B&P model forecasting
    [tags]                    Permission Request, Bartering and pricing, License
    [Documentation]           Check the Bartering and Pricing Model for forecasting
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    HoverText    Show Actions
    TypeText     Search this list...    PR-00024530\n    anchor=Clear
    Sleep        2s
    ClickText    PR-00024530
    VerifyText   PR-00024530
    ClickText    Related
    Sleep        2s