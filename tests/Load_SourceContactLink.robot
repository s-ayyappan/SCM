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
    TypeText                  Search this list...    T-56194\n    anchor=Account Manager, Content Provider, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText                 T-56194

#navigate to the Releated tab

    VerifyField    Title Id    T-56194    partial_match=True
    ClickText      Related
    ClickText      PR-00025146
    ClickText      PR-00025146
    VerifyField    Permission Request Name    PR-00025146    partial_match=True
    HoverText      Fields
    VerifyField    Title Name    CRT Test Source    partial_match=True
    HoverText      Conversations
    ClickText      Related
    ClickText      PRCR-00016756
    ClickFieldValue    Permission Request
    ClickFieldValue    Title Id
    ClickText      Related
    SwipeDown    
    VerifyText    Source Contact links
    ClickText     SCL-00000022
    VerifyField   Source Contact link Name    SCL-00000022    partial_match=True
    VerifyText    Source Contact link
    Log           Source Contact link successfully loaded
    
