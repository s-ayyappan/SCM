# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Delete existing task
    [tags]                    Tasks, Delete Task
    [Documentation]           Delete a task
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Tasks

    ClickText    Select a List View: Tasks
    ClickText    All Open Tasks
    ClickText    Select list display
    ClickText    Table
#create new task
    ClickText    New Task    anchor=Assign Label
#select the subject
    UseModal    On
    ClickText   *Subject     
    TypeText     Subject            Send Letter    anchor=Due Date
    ClickText    Due Date    anchor=Previous Month
    TypeText    Due Date    23/12/2025\n
    PickList    Sub Category    Agreement Update
    PickList    Product Approval    Yes
    TypeText    Comments    Created by CRT script for deletion
    PickList    Priority    Normal
    PickList    Status    Open
    ClickText   Save    partial_match=False
    UseModal    Off
#search the new task in search bar
    Sleep       2s
    RefreshPage
    RefreshPage         
    Sleep       2s
#   TypeText    Search this list...    CRT\n    anchor=Clear
    ClickText    Select a List View: Tasks
    ClickText    All Open Tasks
    
#    ClickText    Today's Tasks
#clean up the new task, by deleting
    ClickCheckbox    Send Letter    On
    ClickText    Show Actions
    ClickText    Send Letter
    VerifyText   Created by CRT script for deletion
    ClickText    Delete    anchor=Cancel and close
    UseModal     On
    ClickText    Delete
    UseModal     Off
#   VerifyText   Success notification.\nTask "Send Letter" was deleted. Undo
    Log          End of the Script for Task Deletion
