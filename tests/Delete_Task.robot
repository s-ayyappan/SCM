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
#create the task in today date
#commenting the today's date function as it produces pop up on these tasks 28/08/2025
#    ${today}=    Get Current Date    result_format=${DATE_FORMAT}                 
#    Log    Today's date is: ${today}
#    TypeText    Due Date    ${today}\n
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
    TypeText    Search this list...    CRT script\n    anchor=Clear
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
