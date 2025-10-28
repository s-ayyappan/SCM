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
    TypeText                  Search this list...    T-00101\n    anchor=Account Manager, Content Provider, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText                 T-00101

#navigate to the Releated tab

    VerifyField    Title Id    T-00101    partial_match=True
    ClickText      Related
    ClickText      PR-00024346
    ClickText      PR-00024346
    VerifyField    Permission Request Name    PR-00024346    partial_match=True
    HoverText      Fields
    VerifyField    Title Name    CRT Test Source    partial_match=True
    HoverText      Conversations
    ClickText      Related
    ClickText      RCR-00016798
    ClickFieldValue    Permission Request
    ClickFieldValue    Title Id
    ClickText      Related
    SwipeDown    
    VerifyText    Source Contact links
    ClickText     SL-013929
    VerifyField   Source Contact link Name    SL-013929    partial_match=True
    VerifyText    Source Contact link
    Log           Source Contact link successfully loaded
    
