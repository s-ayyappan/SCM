*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Reports tab UI check
    [tags]                    Tasks
    [Documentation]           Test to check the UI compoents in Reports tab
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Reports    
    Sleep                     2s    


    VerifyText    Reports
    VerifyText    New Folder
    VerifyText    New Report
    VerifyText    New Report
    VerifyText    Recent
    VerifyText    Created by Me
    VerifyText    Private Reports
    VerifyText    Public Reports
    VerifyText    All Reports
    VerifyText    All Folders
    VerifyText    Created by Me
    VerifyText    Shared with Me
    VerifyText    All Favorites
    ClickText    All Folders
    ClickText    All Reports
    VerifyText    Report Name
    VerifyText    Description
    VerifyText    Folder
    VerifyText    Created By
    VerifyText    Show actions
    VerifyText    Created On
