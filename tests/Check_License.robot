# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Check License tab    
    [tags]                    Licenses
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Licenses

    ClickText    Select a List View: Licenses
    ClickText    All
    ClickText    L-000046
    ClickText    Licenses
    TypeText     Search this list...    L-000046\n    anchor=Account, Effective Date, License Template, and Version aren't searchable. Use filters or sort on these fields instead.
    Sleep        2s
    ClickText    L-000046
    VerifyText   L-000046
    Sleep        2s
    #navigate to the tabs
    ClickText    Related
    ClickText    Source Link Management
    ClickText    Details