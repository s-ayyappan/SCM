# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Check Cases
    [tags]                    Cases
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Cases

    #Cases tab opening
    ClickText    Select a List View: Cases
    #list all cases
    ClickText    All cases
    #click and load the first case
    ClickText    00001007
    #navigate to the tabs
    ClickText    Related
    HoverText    Details
    ClickText    Details
    #check the status bar
    ClickText    Open
    ClickText    Closed    anchor=Mark Status as Complete
    ScrollText    Recent Items

