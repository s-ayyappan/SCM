*** Settings ***
Library           QForce
Library           QWeb
Library           QVision
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Check Email Navigation
    [tags]                    Cases
    [Documentation]           Check the Email Navigation is working as expected
    Sleep                     1s
    LaunchApp                 Cases

#open Serial Content cases
    ClickText    Select a List View: Cases
    ClickText    All cases
    TypeText     Search this list...    00001867\n    anchor=Change Owner
    Sleep        1s