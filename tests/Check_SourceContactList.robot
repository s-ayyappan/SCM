*** Settings ***
Library    QForce
Library    String
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Source Contact List
    [tags]                    Sources    SourceContact List
    [Documentation]           Check Source Contact List for a source
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Sources

#Search for the source
    TypeText                  Search this list...    New Robot Title\n    anchor=Account Manager, Created Date, and Content Provider aren't searchable. Use filters or sort on these fields instead.
    RefreshPage
    VerifyText                New Robot Title        
    ${Sources}=               Set Variable   T-
    ClickElement              //a[contains(@title,'${Sources}')]
    

    ClickText                 Related
    SwipeDown
    SwipeDown
    VerifyText                Source Contact links
  #  ClickText                 Source Contact links anchor=1 timeout=1
   # ClickElement      //*[@id\='\"tab-2\"']/slot[1]/flexipage-component2[2]/slot[1]/lst-related-list-container[1]/div[1]/div[7]/lst-related-list-single-container[1]/laf-progressive-container[1]/slot[1]/lst-related-list-single-app-builder-mapper[1]/article[1]/lst-related-list-view-manager[1]/lst-common-list-internal[1]/lst-list-view-manager-header[1]/div[1]/div[1]/div[1]/div[1]/div[1]/h2[1]/a[1]
 #  ClickElement               /html/body/div[4]/div[1]/section/div[1]/div[2]/div[2]/div[1]/div/div/div/div[5]/div/div/one-record-home-flexipage2/forcegenerated-adg-rollup_component___force-generated__flexipage_-record-page___-s-c-m_-title_-record_-page___-title__c___-v-i-e-w___-l-m-t___1740397600000/forcegenerated-flexipage_scm_title_record_page_title__c__view_js___lmt___1740397600000/record_flexipage-desktop-record-page-decorator/div[1]/records-record-layout-event-broker/slot/slot/flexipage-record-home-template-desktop2/div/div[2]/div[1]/slot/flexipage-component2/slot/flexipage-tabset2/div/lightning-tabset/div/slot/slot/flexipage-tab2[1]/slot/flexipage-component2[2]/slot/lst-related-list-container/div/div[7]/lst-related-list-single-container/laf-progressive-container/slot/lst-related-list-single-app-builder-mapper/article/lst-related-list-view-manager/lst-common-list-internal/lst-list-view-manager-header/div/div[1]/div[1]/div/div/h2/a/span[1]
    