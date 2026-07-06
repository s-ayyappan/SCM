*** Settings ***
Library           QForce
Library           QWeb
Library           QVision
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Check New Case Related fields
    [tags]                    Case, Serial Content
    [Documentation]           Check cases related fields
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Cases
    
#create new Serial Content case   --this functionality is removed from case 30/06/2026
#    ClickText    Serial Content
#    ClickText   New    anchor=Chage Owner, Assign Label
#    UseModal    On
#    ClickText   Serial Content
#    ClickText   Next
#    ComboBox    Search Contacts...    Auto CRT
#    PickList    *Case Origin    Email
#    PickList    *Category    Content Delivery
#    PickList    *Sub Category    Access set-up clarification
#    TypeText    Subject    CRT Case
#    ClickText   Save    partial_match=False
#    UseModal    Off
#    VerifyText  created.
#    VerifyText  Auto CRT
#    Log         Able to successfully open a new case

#clean up the newly crated case
#    LaunchApp    Cases
    RefreshPage
#navigate to all cases
    Sleep        2s
    VerifyText    Cases
    ClickText    Select a List View: Cases
    ClickText    All cases
    Sleep        2s
    ClickCheckbox    Select Item 1    on    partial_match=False
    TypeText    Search this list...    test\n
    ClickText    test    partial_match=False
    VerifyText    Case
    ClickText    Related
    VerifyText    Emails
    VerifyText    Case Comments
    VerifyText    Case History
    VerifyText    Notes
    VerifyText    Files
    VerifyText    Open Activities
    VerifyText    Activity History
    VerifyText    Attachments
    ScrollText    Open
    ScrollText    Open
    VerifyText    Details
    VerifyField    Case Owner    Myles Selvey    tag=a    partial_match=True
    ClickText    Activites
    Log         Able to successfully check related fields

