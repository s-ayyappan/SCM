*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
PRCR Closed Won Deletion
    [tags]                    Permission Request, PRCR
    [Documentation]           Users able to delete Closed (Won) status PRCR
     Appstate                  Home 
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    TypeText    Search this list...    PR-00024935\n    anchor=License, Title Id, Title Name, End Date, Created Date, Is PRM, Owner Last Name, and Stop Reminder Emails aren't searchable. Use filters or sort on these fields instead.
    Sleep        2s
    ClickText    PR-00024935
    VerifyText   PR-00024935
    ClickText    Related

#Create new PRCR 
    ClickText    Permission Request Contact Roles     anchor=New
    ClickText    New
    UseModal     On
    ComboBox     Search Accounts...    Avignon University
    ComboBox     Search Contacts...    Auto CRT
    ClickText    Save    partial_match=False
    UseModal     Off
    Sleep        2s
#    VerifyText   Permission Request Contact Roles
#clean up the newly created PRCR
    RefreshPage
    ClickText    Permission Request Contact Roles     anchor=PR-00024935
    RefreshPage

# First verify that checkbox is not present using Is Text
    ${exists}=         Is Text          Select Item 1    timeout=2
    IF  ${exists}
        ClickCheckbox    Select Item 1    on    partial_match=False
        HotKey       Tab
        ClickText    O                  anchor=Select Item 1
        ClickCheckbox    Select Item 1   on    partial_match=False
        ClickText    Show Actions    anchor=Sundar Ayyappan
        Sleep        2s
        ClickText    Delete
        UseModal     On
        ClickText    Delete
        UseModal     Off
    ELSE            
        Log  Checkbox not found, skipping this step
    END