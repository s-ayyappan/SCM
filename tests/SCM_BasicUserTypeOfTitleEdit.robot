*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
SCM Basic User Edit type of Title Validation
    [tags]                    Sources
    Appstate                  Home
    Sleep                     2s
    
#open SF setup and login as SCM basic user  
    ClickText    Setup
    ClickText    Opens in a new tab
    ClickText    Vallavan Udayaraj
    ClickText    Users
    TypeText     Search Setup    vallavan udayaraj
    ClickText    Login
    ClickText    Sources
    TypeText     Search this list...    copado title\n    anchor=Account Manager, Created Date, and Content Provider aren't searchable. Use filters or sort on these fields instead.
    ClickText    Select a List View: Sources
    ClickText    All Titles
   

    TypeText     Search this list...    Furukawa Electric Review\n    anchor=Clear
    VerifyText   Furukawa Electric Review
    ClickText    T-47231
    ClickText    Edit Type of Title
    PickList     Type of Title    Funding Org Opportunity
    ClickText    Save
    TypeText     Funding Body ID    98292427349
    ClickText    Save
    ClickText    Edit Type of Title
    PickList     Type of Title    Data Monitor
    ClickText    Save
    HoverText    Once filled in, the Content Type, ISSN, E-ISSN, Type of Title, and URL to Terms & Conditions cannot be changed. If you need to make any changes to these fields, please contact your System Administrator.
    VerifyText   Once filled in, the Content Type, ISSN, E-ISSN, Type of Title, and URL to Terms & Conditions cannot be changed. If you need to make any changes to these fields, please contact your System Administrator.
    HoverText    Once filled in, the Content Type, ISSN, E-ISSN, Type of Title, and URL to Terms & Conditions cannot be changed. If you need to make any changes to these fields, please contact your System Administrator.
    ClickText    Cancel

    LaunchApp                 Sources

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