*** Settings ***
Library           QForce
Library           QWeb
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Content delivery tasks to be auto closed
    [tags]                    Licenses
    [Documentation]           Auto-Completion of Task upon Content Delivery Submission SCMS-999 ( in progress)
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Permission Requests
    Sleep                     2s

#Search the PR
    TypeText    Search this list...    PR-00024717\n    anchor=Clear
    ClickText    PR-00024717
    
    
#create a new task
    ClickText    Chatter    anchor=There are no cases to show
    ClickText    Activity
    ClickText    New Task
    ClickText    *Subject
    ClickText    Send Letter           anchor=*Subject
    PickList     Priority    Normal
    ClickText    Save


#delete the created task as clean-up
    VerifyText    Send Letter
    ClickText     Show more actions    anchor=No due date
    ClickText     Delete    anchor=Delete Task
    UseModal      On
    ClickText     Delete
    UseModal      Off

#delete the Content Delivery Submitted date/Time
#    ClickText      Edit Content Delivery Submitted Date/Time
#    ClickText      Select a date for Date    anchor=Content Delivery Submitted Date/Time
#    TypeText       Select a date for Date    ${EMPTY}
#    ClickText      Save
    
    

#    ScrollText    /html[1]/head[1]/link[1]
#    ClickText    Edit Content Delivery Submitted Date/Time
#    ScrollText    Recent Items
#    HoverText    Select a date for Date
    
#    ScrollText     Recent Items
#    HoverText      Select a date for Date
#    VerifyText     09/05/2025
#    ClickText      Save



#    ClickText    Edit Content Delivery Submitted Date/Time
#    ScrollText    Recent Items





