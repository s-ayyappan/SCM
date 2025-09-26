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