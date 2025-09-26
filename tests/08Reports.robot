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