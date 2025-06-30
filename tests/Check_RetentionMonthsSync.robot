
*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Check Rights and Restrictions retention months should not sync
    [tags]                    Rights and Permissions, Rights and Restrictions
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Licenses
    
    ClickText                 Select a List View: Licenses
    ClickText                 Recently Viewed (Pinned list)
    TypeText                  Search this list...    L-010726\n    anchor=License Template
    HoverText                 L-010726
    ClickText                 L-010726


#navigate to rights and permissions
    
#update the retention months in Rights and Restrictions
    ClickText    Rights and Permissions (1)
    ClickText    RP-010514
    ClickText    Rights and Restrictions (7)
    ClickText    RR-063034
    SwipeDown
    ClickText    Edit Retention Term (Months)
    ScrollText    Recent Items
    TypeText    Retention Term (Months)    12
    ClickText    Save
    
#check the PR where the retention month should not be udpated
    SwipeUp
    HoverText    RP-010514
    ClickText    RP-010514
    ClickText    PR-00024931


