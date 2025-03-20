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
    TypeText      Search this list...    New Robot Title\n    anchor=Account Manager, Created Date, and Content Provider aren't searchable. Use filters or sort on these fields instead.
    RefreshPage
    VerifyText    New Robot Title        
    ${Sources}=      Set Variable   T-
    ClickElement     //a[contains(@title,'${Sources}')]
    

    ClickText    Related
    SwipeDown
    ClickText    (1)
    ClickText    SCL-00000006
