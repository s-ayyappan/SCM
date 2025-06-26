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
    TypeText     Search this list...    PR-00024504\n    anchor=Clear
    Sleep        2s
    ClickText    PR-00024504
    VerifyText   PR-00024504
    ClickText    Related
    Sleep        2s

#update bartering and pricing model
    ClickText    Update Bartering and Pricing Model
    UseModal    On
    ClickText    Publish Bartering and Pricing Model
    VerifyText    Update Bartering and Pricing Model
    VerifyText    Barting and pricing model has been updated
    ClickText    Cancel and close
    UseModal     Off
    ClickText    L-010372
    ClickText    Barting and Pricing Line Items          anchor=Permission Requests
    ClickText    BPL-00000124
#verify the loading of Bartering and pricing line item
    VerifyText    Barting and Pricing Line Item
    ClickText    L-010372

