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
    TypeText    Search this list...    PR-00024934\n    anchor=License, Title Id, Title Name, End Date, Created Date, Is PRM, Owner Last Name, and Stop Reminder Emails aren't searchable. Use filters or sort on these fields instead.
    Sleep        2s
    ClickText    PR-00024934
    VerifyText   PR-00024934
    ClickText    Related
 
    SwipeDown
#Click the source link
    ClickText    Source Links           anchor=Rights and Restrictions (End Permission Request)
    ClickCheckbox    Select Item 1   on    partial_match=False
    ClickText        SL              anchor=Active
    VerifyText    Source Link
