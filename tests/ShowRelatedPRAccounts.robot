*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Related Permission Requests for Account
    [tags]                    Permission Request
    [Documentation]           Test to Check Related Permission Requests for Account
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    HoverText    Show Actions
    TypeText     Search this list...    PR-00024535\n    anchor=Clear
    ClickText    PR-00024535
    VerifyText   PR-00024535
    ClickText    Related
    ClickText    Details
    

    VerifyText    Permission Request Name\nPR-00024535
    

    ClickText    Dean Witter Foundation
    VerifyText    Account\nDean Witter Foundation
    ClickText    Related
    ScrollText    Recent Items
    ScrollText    Profile Image

    ClickText    PR-00024535
    VerifyText    Permission Request Name\nPR-00024535
    

#  # First verify that checkbox is not present using Is Text
#    ${exists}=        GetText          

# Verify the checkbox does not exist (exists should be False)
#    IF  ${exists}
#        ClickCheckbox    Select Item 6    on    partial_match=False
#        Log  Checkbox found and PRCR is not deleted when contact is deleted
#    ELSE            
#        Log  Checkbox not found, skipping this step
#    END   