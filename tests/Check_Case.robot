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
    [Documentation]           Check the Cases are able to open and view        
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Cases

#open Serial Content cases
    TypeText     Search this list...    Robotics Testing Case\n    anchor=Change Owner
    Sleep        1s
    ClickText    Robotics Testing Case
    VerifyText   Robotics Testing Case
    VerifyText   User Responded
    VerifyField  Case Owner    Change Owner    partial_match=True
    VerifyField  Case Origin    Email    partial_match=True
    ClickText    View Details
    Log          Able to successfully open a existing case
