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
    ClickText   New
    UseModal    On
    ClickText   Serial Content
    ClickText   Next
    ComboBox    Search Contacts...    Auto CRT
    PickList    *Case Origin    Email
    PickList    *Category    Content Delivery
    PickList    *Sub Category    Access set-up clarification
    ClickText   Save    partial_match=False
    UseModal    Off
    VerifyText  created.
    VerifyText  Auto CRT
    Log         Able to successfully open a new case