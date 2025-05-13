*** Settings ***
Library           QForce
Library           QString
Library           QWeb
Library           QVision
Library           OperatingSystem 
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Keywords ***
Delete Funding Opportunity
    ClickText    Delete
    UseModal    On
    ClickText    Delete
    UseModal    Off


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
      
    VerifyText   Permission Holder Ruben Test
    ClickText    L-010380
    ClickText    Permission Requests    anchor=Barting and Pricing Line Items
    ClickText    PR-00024512
    VerifyField  Type of Title    Funding Org Opportunity  
    HoverText    L-010380
    ClickText    L-010380
    ClickText    Create new Version
#VerifyText   Success notification.\nSuccess\nRecords created
    ClickText    L-010380
    RefreshPage
    Sleep        2s
    ClickText    Permission Requests        anchor=Barting and Pricing Line Items
    VerifyText    New
    ClickCheckbox    Select Item 2    on    partial_match=False
    HotKey       Tab
    ClickText    PR                   anchor=Select Item 2

#verify the Type of Title value    
    VerifyField    Type of Title    Funding Org Opportunity  
    ${sametype}=       GetFieldValue        Type of Title
    IF  '${sametype}' == 'Funding Org Opportunity'
        ClickText   Delete
        UseModal    On  
        ClickText   Delete
        UseModal    Off
    ELSE
        Log    Type of Title not equal
    END








   
 