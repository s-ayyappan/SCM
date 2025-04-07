# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QWeb
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Check License tab    
    [tags]                    Licenses
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Licenses
    ClickText    Select a List View: Licenses
    ClickText    Recently Viewed (Pinned list)
    TypeText    Search this list...    L-000046\n    anchor=License Template
    HoverText    L-000046
    VerifyText    World Scientific Publishing Co Pte Ltd
    ClickText    L-000046
    Sleep        1s
#navigate to the tabs
    ClickText    Related
    Sleep        1s
    ClickText    Source Link Management
    Sleep        1s
    ClickText    Details