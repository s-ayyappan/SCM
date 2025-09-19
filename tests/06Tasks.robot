*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Tasks tab UI check
    [tags]                    Tasks
    [Documentation]           Test to check the UI compoents in Tasks tab
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Tasks

    ClickText    Select a List View: Tasks
    ClickText    All Open Tasks