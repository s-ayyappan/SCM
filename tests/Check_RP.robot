# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Check Right and Permission
    [tags]                    Rights and Permissions
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Licenses
    
    ClickText                 Select a List View: Licenses
    ClickText                 Recently Viewed (Pinned list)
    TypeText                  Search this list...    L-000046\n    anchor=License Template
    HoverText                 L-000046
    VerifyText                World Scientific Publishing Co Pte Ltd
    ClickText                 L-000046
    #VerifyText                License\nL-000046
#navigate to rights and permissions
    
    ClickText                 Rights and Permissions (1)
    VerifyText                Rights and Permissions
    ClickText                 RP-000000
    VerifyText                RP-000000
    VerifyText                L-000046
    VerifyText                PR-00008489
    ClickText                 Source Links (1)
    VerifyText                Source Links
    ClickText                 SL-000000
    HoverText                 Fields
    ClickText                 RP-000000    anchor=Tabs
    ClickText                 Obligations (2)
    VerifyText                Obligations
    ClickText                 O-000000
    VerifyText                O-000000
    ClickText                 RP-000000    anchor=Tabs
    ClickText                 Rights and Restrictions (6)
    ClickText                 RR-000000
    VerifyText                RR-000000
    ClickText                 RP-000000    anchor=Tabs

