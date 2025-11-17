*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Dashboards tab UI check
    [tags]                    Tasks
    [Documentation]           Test to check the UI compoents in Dashboards tab
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Dashboards
    Sleep                     2s    

    VerifyText    Dashboards
    VerifyText    New Dashboard
    VerifyText    New Folder
    VerifyText    Recent
    VerifyText    Created by Me
    VerifyText    Private Dashboards
    VerifyText    All Dashboards
    VerifyText    All Folders
    VerifyText    Created by Me
    VerifyText    Shared with Me
    VerifyText    All Favorites
    ClickText    All Dashboards
    VerifyText    Dashboard Name
    VerifyText    Description
    VerifyText    Folder
    VerifyText    Created By
    VerifyText    Created On

