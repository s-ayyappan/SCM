*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Create New PRCR Delete
    [tags]                    Permission Request
    [Documentation]           Test to delete the PRCR created by CRT script Create_NewPRCRL
    Appstate                  Home 
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    ClickText    Select a List View: Permission Requests
    ClickText    Recently Viewed (Pinned list)
    TypeText    Search this list...    PR-00024934\n    anchor=License, Title Id, Title Name, End Date, Created Date, Is PRM, Owner Last Name, and Stop Reminder Emails aren't searchable. Use filters or sort on these fields instead.
    Sleep        3s
    ClickText    PR-00024934
    VerifyText   PR-00024934
    ClickText    Related

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
        Log    New PRCR successfully deleted
    ELSE
        Log    Checkbox not found, skipping this step
        Log    No New PRCR found for deletion
    END
#end of script


