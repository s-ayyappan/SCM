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
    TypeText                  Search this list...    T-56249\n    anchor=Account Manager, Content Provider, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText                 T-56249

#navigate to the Releated tab
    VerifyField    Title Id    T-56249    partial_match=True
    ClickText      Related
    ClickText      PR-00025184
    ClickText      PR-00025184
    VerifyField    Permission Request Name    PR-00025184    partial_match=True
    HoverText      Fields
    VerifyField    Title Name    CRT Source Link Source   partial_match=True
    HoverText      Conversations
    ClickText      Related
    ClickText      PRCR-00016808
    Sleep          2s
    ClickFieldValue    Permission Request
    Sleep          2s
    ClickFieldValue    Title Id
    Sleep          2s
    ClickText      Related
    SwipeDown    
#navigate to Source Contact link
    VerifyText    Source Contact links
    VerifyText    Source Link
    ClickText    SCL-00000024
    VerifyText    Source Contact link
    VerifyField    Source Contact link Name    SCL-00000024    partial_match=True
    VerifyField    Source    T-56249    tag=a    partial_match=True
    Log           Source Contact link successfully loaded
