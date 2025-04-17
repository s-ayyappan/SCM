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
   # VerifyText   Success notification.\nSuccess\nRecords created
    ClickText    L-010380
    RefreshPage
    Sleep        2s

    ClickText    Related
    VerifyText   Pending
    ClickText    Show Actions    anchor=Select All
    ClickText    Edit    partial_match=False
    UseModal     On
    PickList     Type of Title    Funding Org Opportunity
    ClickText    Cancel    partial_match=False
    UseModal     Off
    ClickText    Show more actions    anchor=Select All
    HoverText    Delete
    ClickText    Delete    anchor=Delete Permission Request
    UseModal     On
    ClickText    Delete
    UseModal     Off


#//*[@id="window"]/span/slot/span/slot/span
#/html/body/div[4]/div[1]/section/div[1]/div[2]/div[2]/div[1]/div/div/div/div[2]/div/div/one-record-home-flexipage2/forcegenerated-flexipage_license_license__c__view_js___lmt___1730980266000/record_flexipage-desktop-record-page-decorator/div[1]/records-record-layout-event-broker/slot/slot/flexipage-record-home-template-desktop2/div/div[2]/div[1]/slot/flexipage-component2[2]/slot/flexipage-tabset2/div/lightning-tabset/div/slot/slot/flexipage-tab2[2]/slot/flexipage-component2/slot/lst-related-list-container/div/div[1]/lst-related-list-single-container/laf-progressive-container/slot/lst-related-list-single-app-builder-mapper/article/lst-related-list-view-manager/lst-common-list-internal/div/div/lst-primary-display-manager/div/lst-primary-display/lst-primary-display-grid/lightning-datatable/div[2]/div/div/table/tbody/tr[2]/th/lightning-primitive-cell-factory/span/div/lightning-primitive-custom-cell/lst-output-lookup/force-lookup/div/records-hoverable-link/div/a/span/slot/span/slot/span