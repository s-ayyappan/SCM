*** Settings ***
Library           QForce
Library           QString
Library           QWeb
Library           QVision
Library           OperatingSystem 
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite

*** Test Cases ***
Check B&P forecasting business model to be enabled at License and account level
    [tags]                    Licenses,Permission Request, B&P
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    HoverText    Show Actions
    TypeText     Search this list...    PR-00024934\n    anchor=Clear
    ClickText    PR-00024934