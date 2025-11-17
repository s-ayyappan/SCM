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
    TypeText     Search this list...    PR-00025184\n    anchor=Title Id, Title Name, Subscription End Date, Created Date, Is PRM, Owner Last Name, and Stop Reminder Emails aren't searchable. Use filters or sort on these fields instead.
    ClickText    PR-00025184
    HoverText    Fields
#create new contract agreement
    ClickText    Create Contract Agreement
    UseModal     On
    ClickText    Create Contract Agreement
    VerifyText   Create Contract Agreement
    ClickText    Press delete or backspace to remove
    ComboBox     Search Accounts...    Codogno Hospital
    ClickText    Save
    UseModal     Off
    Sleep        3s
    VerifyText   Contract Agreement
    ClickText    Related
#navigate to contract agreements
    ClickText    Contract Agreements
    ClickCheckbox    Select Item 1    on    partial_match=False
    ClickText    Show Actions    anchor=Show Contract Agreement Name column actions
    HoverText    Delete
    HoverText    Edit
    ClickText    Delete
    ClickText    Delete
    Sleep        2s    
    VerifyText   was deleted.
    Log          Contract succcessfully deleted.

