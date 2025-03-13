*** Settings ***
Library    QForce
Library    String
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Sources
    [tags]                    Sources    Delete
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Sources

#Search for the source
    TypeText      Search this list...    New Robot Title\n    anchor=Account Manager, Created Date, and Content Provider aren't searchable. Use filters or sort on these fields instead.
    VerifyText    New Robot Title        anchor=1
 #   ClickText     T-55849
    HoverText     Details
    ClickText     Show more actions
    ClickText     Delete
    UseModal      On
    ClickText     Delete
    UseModal      Off
    VerifyText    New Robot Title
#Search again to see the source is deleted successfully
    TypeText      Search this list...    New Robot Title\n    anchor=Account Manager, Created Date, and Content Provider aren't searchable. Use filters or sort on these fields instead.
    VerifyText    Nothing to see here
