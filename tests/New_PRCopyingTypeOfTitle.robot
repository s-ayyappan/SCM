*** Settings ***
Library           QForce
Library           QWeb
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Check New Version of License create PR with Type of Title from Existing PR
    [tags]                    Licenses
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Licenses

#navigate to a license
    ClickText    Select a List View: Licenses
    ClickText    All
    TypeText     Search this list...    L-010380\n    anchor=Account, License Template, Version, and Last Refresh Date aren't searchable. Use filters or sort on these fields instead.
      
    VerifyText    Permission Holder Ruben Test
    ClickText    L-010380
    HoverText    Open Permission Requests (1) Preview
    HoverText    Permission Requests (1)
    ClickText    Permission Requests (1)
    ClickText    PR-00024512
    VerifyField  Type of Title    Funding Org Opportunity    partial_match=True
    HoverText    L-010380
    ClickText    L-010380
    ClickText    Create new Version
    VerifyText   Success notification.\nSuccess\nRecords created
    ClickText    L-010380
    ClickText    Permission Requests (2)
    VerifyText    Open PR-00024925 PreviewOpen PR-00024925 Preview\nPending
    ClickText    PR-00024925
    VerifyField  Type of Title    Funding Org Opportunity    partial_match=True
    ClickText    L-010380
    ClickText    Permission Requests (1)
    ClickText    Show Actions    anchor=Show Version column actions
    ClickText    Delete
    UseModal    On
    ClickText    Delete
    UseModal    Off
