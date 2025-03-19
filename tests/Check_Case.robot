*** Settings ***
Library           QForce
Library           QWeb
Library           QVision
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Check Cases
    [tags]                    Cases
    [Documentation]           Cehck the Cases are able to open and view        
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Cases

#open Serial Content cases
    
    ClickText    Select a List View: Cases
    ClickText    Serial Content
    TypeText    Search this list...    Robotics\n    anchor=Change Owner
