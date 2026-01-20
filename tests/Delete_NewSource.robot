*** Settings ***
Library    QWeb
Library    QForce
Library    String
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Delete Source
    [tags]                    Sources    Delete
    [Documentation]           Deleting a new source which was created during robotic testing
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Sources

#create new source for this script
    ClickText    New
    UseModal     On
    ClickText    Next
    VerifyText   New Source: Full
    TypeText     *Title Name    New CRT Title
    ComboBox     Search Accounts...    Codogno Hospital
    MultiPickList    License/SourceLink creation Process    Auto
    ClickText    Move selection to Chosen    anchor=Auto
    ClickText    Save    partial_match=False
    UseModal     Off
    RefreshPage
    Sleep        3s
#Search for the source
    ClickText     Sources
    TypeText      Search this list...    New CRT Title\n    anchor=Account Manager, Created Date, and Content Provider aren't searchable. Use filters or sort on these fields instead.
    VerifyText    New CRT Title        
#   ClickText    (//div[@class='slds-truncate']//div) timeout=10
#    ClickText  class='slds-truncate'                  
    ClickText     Show Actions
    ClickText     Delete
    UseModal      On
    ClickText     Delete
    UseModal      Off
    Log   Source Successfully deleted
#Search again to see the source is deleted successfully
    TypeText      Search this list...    New CRT Title\n    anchor=Account Manager, Created Date, and Content Provider aren't searchable. Use filters or sort on these fields instead.
    ${check_text1}=                       IsText             Nothing to see here    2
    ${check_text2}=                       IsText             New CRT Title    2
    IF  ${check_text1}
        Log   Source Successfully deleted
        ClickText     Sources
    ELSE
        Log   Source not deleted
        ClickText     Sources
    END



