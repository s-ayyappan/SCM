# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Check Tasks tab    
    [tags]                    Tasks
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Tasks

    ClickText    Select a List View: Tasks
    ClickText    All Open Tasks
    ClickText    Overdue Task
    ClickText    Related
    ClickText    Chatter    anchor=Related
    ClickText    HTML Viewer
    #navigate to the Details tabs
    ClickText    Details    partial_match=False
