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
Create New Task
    [tags]                    Tasks, Create Task
    [Documentation]           Create New Task
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Tasks

    ClickText    Select a List View: Tasks
    ClickText    All Open Tasks
    RefreshPage
#create new task
    ClickText    Select list display
    ClickText    Table
    RefreshPage
    ClickText    New Task    anchor=Assign Label
#select the subject
    UseModal    On
    ClickText   *Subject
    Sleep        1s
    TypeText     Subject            Send Letter    anchor=Due Date
    Sleep        1s
    ClickText    Due Date    anchor=Previous Month
    ClickText    Due Date    anchor=Pick a Year
#create the task in today date
#commenting the today's date function as it produces pop up on these tasks 28/08/2025
#    ${today}=    Get Current Date    result_format=${DATE_FORMAT}                 
#    Log    Today's date is: ${today}
#    TypeText    Due Date    ${today}\n
    PickList    Sub Category    Agreement Update
    PickList    Product Approval    Yes
    TypeText    Comments    Created by CRT script
    PickList    Priority    Normal
    PickList    Status    Open
    ClickText    Save    partial_match=False
    ClickText    Cancel and close
    UseModal    Off
#search the new task in search bar
    RefreshPage
    Sleep       2s
    ClickText    Select a List View: Tasks
    ClickText    All Open Tasks 
#   TypeText    Search this list...    Send Letter\n
    Sleep       2s
    
#clean up the new task, by deleting
    ClickCheckbox    Send Letter    On
    ClickText    Show Actions
    ClickText    Delete
    UseModal     On
    ClickText    Delete
    UseModal     Off

#    VerifyText    Success notification.\nTask was deleted. Undo
    Log           End of the Script for Task Creation
