# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Create New Task
    [tags]                    Tasks, Create Task
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Tasks

    ClickText    Select a List View: Tasks
    ClickText    All Open Tasks
#create new task
    ClickText    Select list display
    ClickText    Table
    ClickText    New Task    anchor=Assign Label
#select the subject
    UseModal    On
    ClickText   *Subject
    ClickText   Send Letter    anchor=Due Date
    PickList    Sub Category    Agreement Update
    PickList    Product Approval    Yes
    TypeText    Comments    Created by CRT script
    PickList    Priority    Normal
    PickList    Status    Open
    ClickText   Save    partial_match=False
    UseModal    Off
#search the new task in search bar
    RefreshPage
    Sleep       2s
    TypeText    Search this list...    CRT\n    anchor=Clear
#clean up the new task, by deleting
    ClickCheckbox    Send Letter    On
    ClickText    Show Actions
    ClickText    Send Letter
    VerifyText    Created by CRT script
    ClickText    Delete    anchor=Cancel and close
    UseModal    On
    ClickText    Delete
    UseModal    Off
    VerifyText    Success notification.\nTask "Send Letter" was deleted. Undo
    Log           End of the Script for Task Creation