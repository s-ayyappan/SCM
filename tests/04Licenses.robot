*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Licenses Tab UI Checks
    [tags]                    Licenses
    [Documentation]           Sources tab UI check
    Appstate                  Home
    LaunchApp                 Licenses
    Sleep                     2s    

#capture the UI objects in New License Modal