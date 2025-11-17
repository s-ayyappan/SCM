*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Edit type of Title
    [tags]                    Sources
    [Documentation]           Type of Title can be edit if no value exist
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Sources

#scms-1027 ticket functionality
#logged in as SF admin
#search the source
    TypeText                  Search this list...    Copado title\n    anchor=Account Manager, Created Date, and Content Provider aren't searchable. Use filters or sort on these fields instead.
    VerifyText                Copado Title
    ClickText                 T-55900
    VerifyField               Title Name    Copado Title    partial_match=True
    VerifyField               Type of Title    Funding Org Opportunity    partial_match=True
#edit the type of title to new value from drop down
    ClickText                 Edit Type of Title
    PickList                  Type of Title    Data Monitor
#save the newly set value
    ClickText                 Save
    Sleep                     2s
    Log                       New Type of Title saved successfully
#reset the value to the original type of title for CRT purpose
    ClickText                 Edit Type of Title
    ScrollText                Recent Items
    PickList                  Type of Title    Funding Org Opportunity
    ClickText                 Save
#save the newly set value
    Sleep                     2s    
