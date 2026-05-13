*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
PR Closed Won Deletion PRCR
    [tags]                    Permission Request, PRCR
    [Documentation]           Users able to delete Closed (Won) status PR's releted PRCR
    Appstate                  Home 
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    ClickText    Select a List View: Permission Requests
    ClickText    Recently Viewed (Pinned list)
    TypeText    Search this list...    PR-00024935\n    anchor=License, Title Id, Title Name, End Date, Created Date, Is PRM, Owner Last Name, and Stop Reminder Emails aren't searchable. Use filters or sort on these fields instead.
    Sleep        2s
    ClickText    PR-00024935
    VerifyText   PR-00024935

#check the status of PR 
    SwipeDown
    VerifyText    Status
    VerifyText    Closed (Won)
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
#Delete the newly created PRCR
    RefreshPage
    ClickText    Permission Request Contact Roles     anchor=PR-00024935
    RefreshPage

#clean up the newly created PRCR
    ClickText    Permission Request Contact Roles     anchor=New
# First verify that checkbox is present
    ${exists}=    Is Text    Select Item 1             
    IF    '${exists}' == 'True'
        ClickCheckbox    Select Item 1    on    partial_match=False
        ClickText    Show Actions    anchor=Show Contact Inactive column actions
        ClickText    Delete
        UseModal     On
        VerifyText   Delete Permission Request Contact Role
        ClickText    Delete
        Sleep        3s
        VerifyText   was deleted.
        UseModal    Off
        Log     User able to deleted PRCR of Closed won status PR
    ELSE
        Log    Checkbox not found, skipping this step
    END
#end of script

