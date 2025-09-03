# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Library    DateTime
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Variables ***
${DATE_FORMAT}    %d/%m/%Y  

*** Test Cases ***
Delete existing task 2nd part
    [tags]                    Tasks, Delete Task
    [Documentation]           Delete a task 2nd Part
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Tasks

    ClickText    Select a List View: Tasks
    ClickText    All Open Tasks
    ClickText    Select list display
    ClickText    Table
    Sleep       2s
    TypeText    Search this list...    CRT script for deletion\n    anchor=Clear
#clean up the new task, by deleting
    ClickCheckbox    Send Letter    On
    ClickText    Show Actions
    ClickText    Send Letter
    VerifyText   Created by CRT script
    ClickText    Delete    anchor=Cancel and close
    UseModal     On
    ClickText    Delete
    UseModal     Off
    Log          End of the Script for Task Deletion
