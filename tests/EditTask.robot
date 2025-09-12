# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Edit Tasks
    [tags]                    Tasks Edit
    [Documentation]           Editing tasks
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Tasks

#change to table view
    ClickText    Select list display
    ClickText    Table
    Sleep        2s
    ClickCheckbox    DOAJ - multiple template found    On
    ClickText    DOAJ - multiple template found
#click the first task in the list
    ClickText    Edit Comments    anchor=Delete
    UseModal     On
#add new line to the comments
    TypeText     Comments    \nCRT added text
    ClickText    Save    partial_match=False
    UseModal     Off
    HoverText    Save
    ClickText    Edit Subject
    ClickText    Cancel
    VerifyText   CRT added text
#Delete the added comments
    ClickText    Edit Comments    anchor=Delete
    UseModal     On
    TypeText     Comments     \n
    ClickText    Save         partial_match=False
    UseModal     Off
    Log          Task successfully edited