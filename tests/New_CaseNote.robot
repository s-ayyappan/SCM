*** Settings ***
Library           QForce
Library           QWeb
Library           QVision
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
New Note in Cases
    [tags]                    Cases
    [Documentation]           Check the New Note can be added to Cases
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Cases

#open Serial Content cases
    ClickText    Select a List View: Cases
    ClickText    All cases
    TypeText     Search this list...    Robotics Testing Case\n    anchor=Change Owner
    Sleep        1s
    ClickText    Robotics Testing Case
    VerifyText   Robotics Testing Case
    VerifyText   User Responded
    VerifyField  Case Owner    Change Owner    partial_match=True
    VerifyField  Case Origin    Email    partial_match=True
    VerifyField  Priority    Medium    partial_match=True
    ClickText    Details
    ClickText    Related
    Log          Able to successfully open a existing case

#add a new note to the case
    ClickText    New Note
    TypeText    Untitled Note    Robotics note
    TypeText    Compose text    This note is added by CRT script
    ClickText    Done
    ClickText    Related
    ClickText    Notes          anchor=New
    ClickText    Robotics note
    VerifyText    This note is added by CRT script
    UseModal    Off
    ClickText    Close    partial_match=False
    Log          Able to successfully create a note to a case 
    
#delete the newly created note
    ClickText    Show Actions
    ClickText    Delete    anchor=Delete File?
    UseModal     On
    ClickText    Delete
    Log          Able to successfully delete a note in a case 
