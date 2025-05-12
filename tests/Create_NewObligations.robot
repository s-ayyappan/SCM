*** Settings ***
Library    QForce
Library    QVision
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Create New Obligation in PR
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
    Sleep        2s

#Create new Obligation for the PR

    SwipeDown
    VerifyText    Obligations 
    ClickText     New    anchor=Mitigatable Value
    UseModal      On
    ComboBox      Search Rights and Permissions...    RP-010166
    PickList      Type    Attribution
    PickList      Status    Pending
    ClickText     Save    partial_match=False
    UseModal      Off
    SwipeUp       
    SwipeUp       
#Navigate to the obligations thru the license->RP->obligations
    ClickText    L-010380
    ClickText    Rights and Permissions (1)
    ClickText    RP-010166
    ClickText    Obligations                        

#Select the last created obligations using hotkeys and delete
    ClickCheckbox    Select Item 5    on    partial_match=False
    HotKey       Tab
    HotKey       Enter 
    Sleep        2s   
    ClickText    Delete
    UseModal     On
    ClickText    Delete
