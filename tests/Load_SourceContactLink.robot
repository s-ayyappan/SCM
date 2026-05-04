*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Load Source Contact Link Loading
    [tags]                    Sources
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Sources

#search the title
    TypeText                  Search this list...    T-57091 \n    anchor=Account Manager, Content Provider, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText                 T-57091 

#navigate to the Releated tab
    VerifyField    Title Id    T-57091   partial_match=True
    ClickText      Related
    ClickText      PR-00026099
    ClickText      PR-00026099
    VerifyField    Permission Request Name    PR-00026099   partial_match=True
    HoverText      Fields
    VerifyField    Title Name    NEWCRTSource   partial_match=True
    HoverText      Conversations
    ClickText      Related
    ClickText      PRCR-00017725
    Sleep          2s
    ClickFieldValue    Permission Request
    Sleep          2s
    ClickFieldValue    Title Id
    Sleep          2s
    ClickText      Related
    SwipeDown    
#navigate to Source Contact link
    VerifyText    Source Contact link
    ClickText     SCL-00000137
    VerifyText    Source Contact link
    VerifyField   Source Contact link Name    SCL-00000137    partial_match=True
    VerifyField   Source    T-57091    tag=a    partial_match=True
    Log           Source Contact link successfully loaded
