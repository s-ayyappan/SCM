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
    Sleep                     3s

#create new source for this script
    ClickText    Sources List
    ClickText    New Source
    UseModal    On
    VerifyText    New Source
    VerifyText    Full
    ClickText    Full
    ClickText    Next
    TypeText     *Title Name    New CRT Title
    ComboBox     Search Accounts...    Codogno Hospital
    MultiPickList    License/SourceLink creation Process    Auto
    ClickText    Move selection to Chosen    anchor=Auto
    PickList    *Content Set    Complete Collection
    MultiPickList    Content Type    Full Content Type Collection
    ClickText    Move selection to Chosen    anchor=Full Content Type Collection
    ClickText    Save    partial_match=False
    UseModal     Off
    RefreshPage
    Sleep        3s
#Search for the source
    ClickText     Sources
    ClickText    Select a List View: Sources
    ClickText    All Titles
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



