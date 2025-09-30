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
    Sleep                     2s

    ClickText    Select list display
    ClickText    Table
    TypeText    Search this list...    CRT script\n    anchor=Assigned Alias, Due Date, Name, and Related To aren't searchable. Use filters or sort on these fields instead.
    Sleep        1s

#clean up the new task, by deleting
    ClickText    Send Letter
    ClickText    Delete    anchor=Cancel and close
    UseModal    On
    HoverText    Task Reminder Notification:
    ClickText    Delete
    VerifyText    1 new notifications\n\n\nApp Launcher\nSCM\nHome\nChatter\nTasks\nTasks List\nAccounts\nAccounts List\nContacts\nContacts List\nSources\nSources List\nLicenses\nLicenses List\nPermission Requests\nPermission Requests List\nDocuSign Envelopes\nDocuSign Envelopes List\nProjects\nProjects List\nDashboards\nDashboards List\nReports\nReports List\nLicense Templates\nLicense Templates List\nConversations\nConversations List\n\nEdit nav items\n\nTasks\nTasks\nRecently Viewed\n\nSelect a List View: Tasks\n\nThis list is pinned.\nNew Task\nAssign Label\n0 items • Updated a few seconds ago\n\nSearch this list...\n\nClear\n\nList View Controls\n\nSelect list display\n\nRefresh\n\nColumn sort is unavailable for this object.\n\nEdit List\n\nCharts\n\nFilters\nItem Number\n\nSort\nSubject\n\nShow Subject Column Actions\n\nSort\nName\n\nShow Name Column Actions\n\nSort\nRelated To\n\nShow Related To Column Actions\n\nSort\nDue Date\n\nShow Due Date Column Actions\n\nSort\nAssigned Alias\n\nShow Assigned Alias Column Actions\n\nAction\n\nNo items to display.\n\n\nQuick Training\n\nRecent Items\nSuccess notification.\nTask "Send Letter" was deleted. Undo
#    ClickCheckbox    Send Letter    On
#    ClickText    Show Actions
#    ClickText    Send Letter
#    VerifyText   Created by CRT script
#    ClickText    Delete    anchor=Cancel and close
#    UseModal     On
#    ClickText    Delete
#    UseModal     Off
    Log          End of the Script for Task Deletion
