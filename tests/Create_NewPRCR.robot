*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Create New PRCR
    [tags]                    Permission Request
    [Documentation]           Test to create PRCR under Permission Request 
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    TypeText    Search this list...    PR-00024512\n    anchor=License, Title Id, Title Name, End Date, Created Date, Is PRM, Owner Last Name, and Stop Reminder Emails aren't searchable. Use filters or sort on these fields instead.
    Sleep        2s
    ClickText    PR-00024512
    VerifyText   PR-00024512
    ClickText    Related

#Create new PRCR 
    ClickText    Permission Request Contact Roles
    ClickText    New
    UseModal     On

#    ComboBox    Search Permission Requests...    PR-00024512
  #  ClickText    Clear Selection
    ComboBox     Search Accounts...    Aalborg University
    ComboBox     Search Contacts...    Julie Roy
    ClickText    Save    partial_match=False
    UseModal     Off

#clean up the newly created PRCR
    RefreshPage
    ClickText    Permission Request Contact Roles
    ClickCheckbox    Select Item 6    on    partial_match=False
    ClickText    Show Actions    anchor=Ramadurga Muthuirlandy
    Sleep        2s
    ClickText    Delete
    UseModal     On
    ClickText    Delete
    UseModal     Off
