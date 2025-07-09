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
  
    ClickText    Show more actions
    ClickText    New Task
    UseModal    On
#select the subject
    ClickText   Send Letter    anchor=Subject
    PickList    Sub Category    Agreement Update
    PickList    Product Approval    Yes
    TypeText    Comments    Created by CRT script
    PickList    Priority    Normal
    PickList    Status    Open
    ClickText   Save    partial_match=False
    UseModal    Off
#search the new task in search bar
    TypeText    Search this list...    CRT\n    anchor=4 items •
    ClickText   Overdue Task
    VerifyText  Task Created by CRT
    VerifyText  Created by CRT script


    ClickText   Show more actions    parent=DIV
    ClickText   New Task
    UseModal    On
    ClickText   Send Letter
    HoverText   Press Delete to Remove


