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
    TypeText                  Search this list...    T-56243\n    anchor=Account Manager, Content Provider, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText                 T-56243

#navigate to the Releated tab

    VerifyField    Title Id    T-56243    partial_match=True
    ClickText      Related
    ClickText      PR-00025180
    ClickText      PR-00025180
    VerifyField    Permission Request Name    PR-00025180    partial_match=True
    HoverText      Fields
    VerifyField    Title Name    Indian Journal of Social Psychiatry   partial_match=True
    HoverText      Conversations
    ClickText      Related
    ClickText      RCR-00016798
    ClickFieldValue    Permission Request
    ClickFieldValue    Title Id
    ClickText      Related
    SwipeDown    
    VerifyText    Source Contact links
    VerifyText    Source Link
    VerifyField   Right and Permission    RP-008756    tag=a    partial_match=True
    Log           Source Contact link successfully loaded
