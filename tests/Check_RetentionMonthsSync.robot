
*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Check Rights and Restrictions retention months sync
    [tags]                    Rights and Permissions, Rights and Restrictions
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Licenses
    
    ClickText                 Select a List View: Licenses
    ClickText                 Recently Viewed (Pinned list)
    TypeText                  Search this list...    L-010726\n    anchor=License Template
    HoverText                 L-010726
    VerifyText                World Scientific Publishing Co Pte Ltd
    ClickText                 L-010726
    #VerifyText                License\nL-010726
#navigate to rights and permissions
    
    ClickText                 Rights and Permissions (1)
    VerifyText                Rights and Permissions