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
#navigate to Permission Requests
    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    ClickText    Select a List View: Permission Requests
    ClickText    Recently Viewed (Pinned list)
    HoverText    False
    TypeText     Search this list...    PR-00003474\n    anchor=Title Id, Title Name, Subscription End Date, Created Date, Is PRM, Owner Last Name, and Stop Reminder Emails aren't searchable. Use filters or sort on these fields instead.
    ClickText    PR-00003474
    HoverText    Fields
#create new contract agreement


    ClickText    Create Contract Amendment
    UseModal    On
    ClickText    Save
    UseModal    Off
    Sleep        5s
    VerifyText   Create Contract Amendment
    ClickText    Related
#navigate to contract agreements
    ClickText    Show Actions    anchor=Show Contract Agreement Name column actions
    ClickText    Delete    anchor=Delete Contract Agreement
    UseModal     On
    ClickText    Delete
    Sleep        5s
    VerifyText   was deleted. Undo     partial_match=True
    Sleep        3s
    Log          Contract succcessfully deleted.



