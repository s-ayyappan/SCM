*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Licenses Tab UI Checks
    [tags]                    Licenses
    [Documentation]           Licenses tab UI check
    Appstate                  Home
    LaunchApp                 Licenses
    Sleep                     2s    

#capture the UI objects in New License Modal

    VerifyText   Import
    VerifyText   Assign Label
    VerifyText    New
    ClickText    New
    UseModal    On
    VerifyText    New License
    VerifyText    Information
    VerifyText    License Template   
    VerifyText    Agreement Type
    VerifyText    Status
    VerifyText    Origin
    VerifyText    Is Sensitive   
    VerifyText    Negotiation License
    VerifyPickList    Currency   
    VerifyText    Automatic Renewal
    VerifyText    Effective Date
    VerifyText    End Date
    VerifyText    Description
    VerifyText    Account Name
    VerifyText    Version Detail
    VerifyText    Version    partial_match=False
    VerifyText    Last Refresh Date
    VerifyText    Agreement Date
    VerifyText    To Refresh
    VerifyText    System Information
    VerifyText    Created By
    VerifyText    Last Modified By
    VerifyText    Cancel
    VerifyText    Save & New
    VerifyText    Save
    VerifyText    Cancel and close
    UseModal    Off
