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

#Search for the source
    TypeText      Search this list...    New Robot Title\n    anchor=Account Manager, Created Date, and Content Provider aren't searchable. Use filters or sort on these fields instead.
    VerifyText    New Robot Title        
 #   ClickText    (//div[@class='slds-truncate']//div) timeout=10
#    ClickText  class='slds-truncate'                  
    ClickText    Show Actions
    ClickText    Delete
    UseModal      On
    ClickText     Delete
    UseModal      Off
#Search again to see the source is deleted successfully
    TypeText      Search this list...    New Robot Title\n    anchor=Account Manager, Created Date, and Content Provider aren't searchable. Use filters or sort on these fields instead.
    VerifyText    Nothing to see here
    



