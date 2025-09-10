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
    [Documentation]           Check new cases created without related fields
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Cases
    
#create new Serial Content case
#    ClickText    Serial Content
    ClickText   New    anchor=Chage Owner, Assign Label
    UseModal    On
    ClickText   Serial Content
    ClickText   Next
    ComboBox    Search Contacts...    Auto CRT
    PickList    *Case Origin    Email
    PickList    *Category    Content Delivery
    PickList    *Sub Category    Access set-up clarification
    TypeText    Subject    CRT Case
    ClickText   Save    partial_match=False
    UseModal    Off
    VerifyText  created.
    VerifyText  Auto CRT
    Log         Able to successfully open a new case

#clean up the newly crated case
    LaunchApp    Cases
    ClickText    All cases
    TypeText     Search this list...    CRT Case\n    anchor=Date/Time Opened and Case Owner Alias aren't searchable. Use filters or sort on these fields instead.
    Sleep        2s
    ClickText    CRT Case
    Sleep        2s
    VerifyText   CRT Case
    ClickText    Delete
    UseModal     On
    ClickText    Delete
    UseModal     Off
    VerifyText   deleted
    Log          Case successfully deleted
