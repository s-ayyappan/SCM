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
    


    ClickText    Permission Requests
    ClickItem    search-button
    TypeText     Search...    PR-00024931\n    tag=input
    VerifyText   Permission Requests
    ClickText    PR-00024931    anchor=Permission Request Name
#    ClickText    Select a List View: Permission Requests
#    ClickText    All Permission Requests
#    HoverText    Show Actions
#    TypeText     Search this list...    PR-00024931\n    anchor=Clear
#    Sleep        2s
#    ClickText    PR-00024931
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
    ClickText    L-010726
    ClickText    Barting and Pricing Line Items          anchor=Permission Requests
    ClickText    BPL-00000180
#verify the loading of Bartering and pricing line item
    VerifyText    Barting and Pricing Line Item
    SwipeUp
    VerifyText    L-010726

